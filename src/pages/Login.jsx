import React, { useState, useEffect } from 'react';
import { supabase } from '@/lib/supabaseClient';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Leaf, User, Mail, Lock, Sparkles, CheckCircle2 } from 'lucide-react';
import { Link, Navigate, useSearchParams } from 'react-router-dom';
import { useAuth } from '@/lib/AuthContext';
import { Helmet } from 'react-helmet-async';

export default function Login() {
  const { isAuthenticated, isLoadingAuth } = useAuth();
  const [searchParams, setSearchParams] = useSearchParams();
  
  const viewParam = searchParams.get('view');
  const [view, setView] = useState(viewParam === 'signup' ? 'sign_up' : 'sign_in');
  const [displayName, setDisplayName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState(null);

  // Sync view state when query params change (e.g. clicking Header "Sign In" vs "Get Started")
  useEffect(() => {
    if (viewParam === 'signup') {
      setView('sign_up');
    } else if (viewParam === 'forgot') {
      setView('forgot_password');
    } else {
      setView('sign_in');
    }
    setMessage(null);
  }, [viewParam]);

  if (isLoadingAuth) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-50">
        <div className="w-8 h-8 border-4 border-green-200 border-t-green-700 rounded-full animate-spin"></div>
      </div>
    );
  }

  if (isAuthenticated) {
    return <Navigate to="/Dashboard" replace />;
  }

  const isValidEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  const isPasswordEmpty = password.trim().length === 0;

  // Determine button text & disabled state
  let buttonText = "Continue";
  let isButtonDisabled = !isValidEmail || loading;

  if (view === 'sign_up') {
    if (isPasswordEmpty) {
      buttonText = "Continue with magic link";
    } else {
      buttonText = "Create account";
      if (password.length < 6) isButtonDisabled = true;
    }
  } else if (view === 'forgot_password') {
    buttonText = "Send reset instructions";
  } else if (view === 'sign_in') {
    buttonText = isPasswordEmpty ? "Send magic link" : "Sign in";
  }

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (isButtonDisabled) return;

    setLoading(true);
    setMessage(null);

    try {
      if (view === 'sign_up') {
        if (isPasswordEmpty) {
          // Passwordless Signup via OTP / Magic Link
          const { error } = await supabase.auth.signInWithOtp({ 
            email: email.trim(),
            options: {
              emailRedirectTo: `${window.location.origin}/Programs`,
              data: {
                full_name: displayName.trim() || undefined,
                display_name: displayName.trim() || undefined
              }
            }
          });
          if (error) throw error;
          
          // Save pending display name if provided
          if (displayName.trim()) {
            const existingPending = JSON.parse(localStorage.getItem('pendingProfile') || '{}');
            localStorage.setItem('pendingProfile', JSON.stringify({ ...existingPending, name: displayName.trim(), full_name: displayName.trim() }));
          }

          setMessage({ 
            type: 'success', 
            text: 'Magic link sent! Please check your inbox and click the verification link to complete your account setup and access your programs.' 
          });
        } else {
          // Signup with Password + Email Confirmation
          const { data, error } = await supabase.auth.signUp({ 
            email: email.trim(), 
            password,
            options: {
              emailRedirectTo: `${window.location.origin}/Programs`,
              data: {
                full_name: displayName.trim() || undefined,
                display_name: displayName.trim() || undefined
              }
            }
          });
          if (error) throw error;

          if (displayName.trim()) {
            const existingPending = JSON.parse(localStorage.getItem('pendingProfile') || '{}');
            localStorage.setItem('pendingProfile', JSON.stringify({ ...existingPending, name: displayName.trim(), full_name: displayName.trim() }));
          }

          setMessage({ 
            type: 'success', 
            text: 'Account created! Please check your email for the confirmation link to activate your account.' 
          });
        }
      } else if (view === 'forgot_password') {
        const { error } = await supabase.auth.resetPasswordForEmail(email.trim(), {
          redirectTo: `${window.location.origin}/Profile`
        });
        if (error) throw error;
        setMessage({ type: 'success', text: 'Password reset instructions sent to your email.' });
      } else if (view === 'sign_in') {
        if (isPasswordEmpty) {
          const { error } = await supabase.auth.signInWithOtp({ 
            email: email.trim(),
            options: {
              emailRedirectTo: `${window.location.origin}/Programs`
            }
          });
          if (error) throw error;
          setMessage({ type: 'success', text: 'Magic link sent to your email. Click it to sign in instantly.' });
        } else {
          const { error } = await supabase.auth.signInWithPassword({ email: email.trim(), password });
          if (error) throw error;
          // AuthContext handles redirect upon auth change
        }
      }
    } catch (error) {
      setMessage({ type: 'error', text: error.message });
    } finally {
      setLoading(false);
    }
  };

  const getHeaderTitle = () => {
    if (view === 'sign_up') return 'Create your account';
    if (view === 'forgot_password') return 'Reset your password';
    return 'Sign in to your account';
  };

  const getSubTitle = () => {
    if (view === 'sign_up') return 'Join UBI Finder to discover and track income support programs worldwide.';
    if (view === 'forgot_password') return 'Enter your email address and we will send you instructions to reset your password.';
    return 'Welcome back! Sign in with your password or request a passwordless magic link.';
  };

  return (
    <div className="min-h-[calc(100vh-64px)] bg-gradient-to-b from-green-50 via-white to-yellow-50 flex flex-col justify-center py-12 px-4 sm:px-6 lg:px-8">
      <Helmet>
        <title>{view === 'sign_up' ? 'Create Your Account | UBI Finder' : view === 'forgot_password' ? 'Reset Password | UBI Finder' : 'Sign In | UBI Finder'}</title>
      </Helmet>

      <div className="sm:mx-auto sm:w-full sm:max-w-md text-center">
        <div className="flex justify-center mb-3">
          <Link to="/" className="inline-flex items-center gap-2 p-2 bg-green-100/80 border border-green-200 rounded-full shadow-inner">
            <Leaf className="h-6 w-6 text-green-700" />
          </Link>
        </div>
        <h1 className="text-3xl font-extrabold text-green-950 tracking-tight">
          {getHeaderTitle()}
        </h1>
        <p className="mt-2 text-xs md:text-sm text-gray-600 max-w-sm mx-auto leading-relaxed">
          {getSubTitle()}
        </p>
      </div>

      <div className="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
        <Card className="shadow-xl border-green-100 bg-white/95 backdrop-blur-sm">
          <CardContent className="p-6 sm:p-8">
            <form onSubmit={handleSubmit} className="space-y-4">
              
              {/* "What should we call you?" - only on signup */}
              {view === 'sign_up' && (
                <div className="animate-in fade-in duration-200">
                  <label htmlFor="displayName" className="block text-xs font-semibold text-gray-700 mb-1">
                    What should we call you?
                  </label>
                  <div className="relative">
                    <User className="w-4 h-4 text-gray-400 absolute left-3 top-3" />
                    <Input
                      id="displayName"
                      type="text"
                      value={displayName}
                      onChange={(e) => setDisplayName(e.target.value)}
                      placeholder="e.g. Alex or Jane"
                      className="pl-9"
                    />
                  </div>
                </div>
              )}

              <div>
                <label htmlFor="email" className="block text-xs font-semibold text-gray-700 mb-1">
                  Email address <span className="text-red-500">*</span>
                </label>
                <div className="relative">
                  <Mail className="w-4 h-4 text-gray-400 absolute left-3 top-3" />
                  <Input
                    id="email"
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    placeholder="you@example.com"
                    required
                    className="pl-9"
                  />
                </div>
              </div>

              {view !== 'forgot_password' && (
                <div>
                  <div className="flex items-center justify-between mb-1">
                    <label htmlFor="password" className="block text-xs font-semibold text-gray-700">
                      Password <span className="text-gray-400 font-normal">(Optional)</span>
                    </label>
                    {view === 'sign_in' && (
                      <button
                        type="button"
                        onClick={() => {
                          setSearchParams({ view: 'forgot' });
                          setMessage(null);
                        }}
                        className="text-xs text-green-700 hover:text-green-800 font-semibold transition-colors"
                      >
                        Forgot password?
                      </button>
                    )}
                  </div>
                  <div className="relative">
                    <Lock className="w-4 h-4 text-gray-400 absolute left-3 top-3" />
                    <Input
                      id="password"
                      type="password"
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      placeholder={view === 'sign_in' ? 'Leave blank for magic link' : 'Leave blank for magic link, or min 6 chars'}
                      className="pl-9 text-xs sm:text-sm"
                    />
                  </div>
                  <p className="text-[11px] text-gray-400 mt-1">
                    {isPasswordEmpty 
                      ? "💡 No password needed! We will email you a secure 1-click login link." 
                      : "Using a permanent password for direct login."}
                  </p>
                </div>
              )}

              {message && (
                <div className={`p-3.5 text-xs rounded-xl flex items-start gap-2 ${
                  message.type === 'error' 
                    ? 'bg-red-50 text-red-700 border border-red-200' 
                    : 'bg-green-50 text-green-900 border border-green-200 font-medium'
                }`}>
                  {message.type === 'success' && <CheckCircle2 className="w-4 h-4 text-green-700 flex-shrink-0 mt-0.5" />}
                  <span>{message.text}</span>
                </div>
              )}

              <Button
                type="submit"
                disabled={isButtonDisabled}
                className="w-full py-6 text-base font-semibold bg-green-700 hover:bg-green-800 text-white transition-all shadow-md mt-2 disabled:opacity-50"
              >
                {loading ? 'Sending Request...' : buttonText}
              </Button>
            </form>

            {/* Bottom View Switcher Links */}
            <div className="mt-6 pt-5 border-t border-gray-100 text-center text-xs text-gray-600 space-y-2">
              {view === 'forgot_password' ? (
                <button
                  onClick={() => {
                    setSearchParams({});
                    setMessage(null);
                  }}
                  className="text-green-700 hover:text-green-800 font-semibold transition-colors"
                >
                  &larr; Back to sign in
                </button>
              ) : view === 'sign_in' ? (
                <div>
                  Don't have an account?{' '}
                  <button
                    onClick={() => {
                      setSearchParams({ view: 'signup' });
                      setMessage(null);
                    }}
                    className="text-green-700 hover:text-green-800 font-bold hover:underline ml-1"
                  >
                    Sign up
                  </button>
                </div>
              ) : (
                <div>
                  Already have an account?{' '}
                  <button
                    onClick={() => {
                      setSearchParams({});
                      setMessage(null);
                    }}
                    className="text-green-700 hover:text-green-800 font-bold hover:underline ml-1"
                  >
                    Sign in
                  </button>
                </div>
              )}
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
