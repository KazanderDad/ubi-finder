




import { supabase } from "@/lib/supabaseClient";
import React, { useState, useEffect } from "react";
import TopNavBar from "./components/TopNavBar";

export default function Layout({ children }) {
  const [user, setUser] = useState(null);
  const [userProfile, setUserProfile] = useState(null);

  useEffect(() => {
    checkAuth();
  }, []);

  const checkAuth = async () => {
    try {
      // Add a small delay to prevent rate limiting
      await new Promise(resolve => setTimeout(resolve, 100));
      
      const userData = (await supabase.auth.getUser()).data.user;
      setUser(userData);

      // Add another small delay before fetching profile
      await new Promise(resolve => setTimeout(resolve, 100));

      const profiles = (await supabase.from('user_profiles').select('*').match({ created_by: userData.email })).data;
      if (profiles.length > 0) {
        setUserProfile(profiles[0]);
      }
    } catch (error) {
      setUser(null);
      setUserProfile(null);
    }
  };

  return (
    <div>
      <TopNavBar user={user} userProfile={userProfile} />
      <div className="pt-20">
        {children}
      </div>
    </div>
  );
}

