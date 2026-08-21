import React, { createContext, useState, useContext, useEffect } from 'react';
import { supabase } from '@/lib/supabaseClient';
import { useNavigate } from 'react-router-dom';

const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [isLoadingAuth, setIsLoadingAuth] = useState(true);
  const [authError, setAuthError] = useState(null);
  const [authChecked, setAuthChecked] = useState(false);
  const [appPublicSettings, setAppPublicSettings] = useState(null);

  useEffect(() => {
    checkUserAuth();
    
    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      (event, session) => {
        if (event === 'SIGNED_IN' || event === 'TOKEN_REFRESHED') {
          checkUserAuth();
        } else if (event === 'SIGNED_OUT') {
          setUser(null);
          setIsAuthenticated(false);
        }
      }
    );

    return () => {
      subscription.unsubscribe();
    };
  }, []);

  const checkUserAuth = async () => {
    try {
      setIsLoadingAuth(true);
      const { data: { user }, error } = await supabase.auth.getUser();
      if (error || !user) {
        setUser(null);
        setIsAuthenticated(false);
      } else {
        setUser(user);
        setIsAuthenticated(true);

        const pendingProfile = localStorage.getItem("pendingProfile");
        if (pendingProfile) {
          try {
            const data = JSON.parse(pendingProfile);
            if (data && data.country) {
              const cleanProfile = {
                name: data.name || user.user_metadata?.full_name || 'Member',
                country: data.country,
                state: data.state || null,
                municipality: data.municipality || null,
                household_size: Number(data.household_size) >= 1 ? Number(data.household_size) : 1,
                income_range: data.income_range || '0-20k',
                gender: data.gender || 'abstain',
                currency: data.currency || 'USD',
                accepts_digital_currency: data.accepts_digital_currency !== undefined ? Boolean(data.accepts_digital_currency) : true,
                accepts_foreign_currency: data.accepts_foreign_currency !== undefined ? Boolean(data.accepts_foreign_currency) : true,
                is_public: true
              };
              
              let profileId = user?.user_metadata?.profile_id || localStorage.getItem("user_profile_id");
              if (profileId) {
                await supabase.from('user_profiles').update(cleanProfile).eq('id', profileId);
                localStorage.setItem("user_profile_data", JSON.stringify({ ...cleanProfile, id: profileId }));
              } else {
                let res = await supabase.from('user_profiles').insert([{ ...cleanProfile, created_by_id: user.id }]).select();
                if (res.error && (res.error.code === '23503' || res.error.message?.includes('foreign key'))) {
                  res = await supabase.from('user_profiles').insert([cleanProfile]).select();
                }
                if (res.data && res.data[0]?.id) {
                  profileId = res.data[0].id;
                  localStorage.setItem("user_profile_id", profileId);
                  supabase.auth.updateUser({ data: { profile_id: profileId } }).catch(() => {});
                }
                localStorage.setItem("user_profile_data", JSON.stringify({ ...cleanProfile, id: profileId || "local-profile" }));
              }

              localStorage.setItem("pendingProfile", JSON.stringify({ ...cleanProfile, id: profileId }));
              localStorage.removeItem("pendingProfileStep");
            }
          } catch (e) {
            console.error("Error saving pending profile:", e);
          }
        }
      }
      setAuthChecked(true);
    } catch (error) {
      setUser(null);
      setIsAuthenticated(false);
      setAuthChecked(true);
    } finally {
      setIsLoadingAuth(false);
    }
  };

  const logout = async (shouldRedirect = true) => {
    setIsLoadingAuth(true);
    await supabase.auth.signOut();
    setUser(null);
    setIsAuthenticated(false);
    setIsLoadingAuth(false);
    if (shouldRedirect) {
      window.location.href = '/';
    }
  };

  const navigateToLogin = () => {
    window.location.href = '/login';
  };

  const checkAppState = async () => {
    setAppPublicSettings({ public_settings: {} });
  };

  return (
    <AuthContext.Provider value={{ 
      user, 
      isAuthenticated, 
      isLoadingAuth,
      isLoadingPublicSettings: false,
      authError,
      appPublicSettings,
      authChecked,
      logout,
      navigateToLogin,
      checkUserAuth,
      checkAppState
    }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};
