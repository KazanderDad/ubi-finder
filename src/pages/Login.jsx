import React, { useState } from 'react';
import { supabase } from '@/lib/supabaseClient';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Leaf } from 'lucide-react';
import { Link, Navigate, useSearchParams } from 'react-router-dom';
import { useAuth } from '@/lib/AuthContext';

export default function Login() {
  const { isAuthenticated, isLoadingAuth } = useAuth();
  const [searchParams] = useSearchParams();
  const initialView = searchParams.get('view') === 'signup' ? 'sign_up' : 'sign_in';

  const [view, setView] = useState(initialView);
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState(null);

  if (isLoadingAuth) {
    return <div className="min-h-screen flex items-center justify-center">Loading...</div>;
  }

  if (isAuthenticated) {
    return <Navigate to="/dashboard" replace />;
  }

  const isValidEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  const isPasswordEmpty = password.trim().length === 0;

  let buttonText = "Continue";
  let isButtonDisabled = !isValidEmail || loading;

  if (view === 'sign_up') {
    buttonText = "Create account";
    if (password.length < 6) isButtonDisabled = true;
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
        const { error } = await supabase.auth.signUp({ email, password });
        if (error) throw error;
        setMessage({ type: 'success', text: 'Check your email for the confirmation link.' });
      } else if (view === 'forgot_password') {
        const { error } = await supabase.auth.resetPasswordForEmail(email);
        if (error) throw error;
        setMessage({ type: 'success', text: 'Password reset instructions sent.' });
      } else if (view === 'sign_in') {
        if (isPasswordEmpty) {
          const { error } = await supabase.auth.signInWithOtp({ email });
          if (error) throw error;
          setMessage({ type: 'success', text: 'Magic link sent to your email.' });
        } else {
          const { error } = await supabase.auth.signInWithPassword({ email, password });
          if (error) throw error;
          // AuthContext will handle redirect on auth state change
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

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col justify-center py-12 sm:px-6 lg:px-8">
      <div className="sm:mx-auto sm:w-full sm:max-w-md">
        <div className="flex justify-center">
          <Link to="/" className="flex items-center space-x-2">
            <div className="bg-primary p-2 rounded-lg">
              <Leaf className="h-8 w-8 text-white" />
            </div>
            <span className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-primary to-green-600">
              UBI Finder
            </span>
          </Link>
        </div>
        <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
          {getHeaderTitle()}
        </h2>
      </div>

      <div className="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
        <Card>
          <CardContent className="pt-8">
            <form onSubmit={handleSubmit} className="space-y-5">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Email address</label>
                <Input
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="you@example.com"
                  required
                />
              </div>

              {view !== 'forgot_password' && (
                <div>
                  <div className="flex items-center justify-between mb-1">
                    <label className="block text-sm font-medium text-gray-700">Password</label>
                    {view === 'sign_in' && (
                      <button
                        type="button"
                        onClick={() => {
                          setView('forgot_password');
                          setMessage(null);
                        }}
                        className="text-sm text-green-600 hover:text-green-500 font-medium transition-colors"
                      >
                        Forgot your password?
                      </button>
                    )}
                  </div>
                  <Input
                    type="password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder={view === 'sign_in' ? 'Leave blank for magic link' : 'Must be at least 6 characters'}
                  />
                </div>
              )}

              {message && (
                <div className={`p-3 text-sm rounded-md ${message.type === 'error' ? 'bg-red-50 text-red-600 border border-red-100' : 'bg-green-50 text-green-700 border border-green-100'}`}>
                  {message.text}
                </div>
              )}

              <Button
                type="submit"
                disabled={isButtonDisabled}
                className="w-full py-6 text-lg bg-green-700 hover:bg-green-800 transition-colors"
              >
                {loading ? 'Processing...' : buttonText}
              </Button>
            </form>

            <div className="mt-6 text-center">
              {view === 'forgot_password' ? (
                <button
                  onClick={() => {
                    setView('sign_in');
                    setMessage(null);
                  }}
                  className="text-sm text-gray-600 hover:text-gray-900 font-medium transition-colors"
                >
                  Back to sign in
                </button>
              ) : view === 'sign_in' ? (
                <button
                  onClick={() => {
                    setView('sign_up');
                    setMessage(null);
                  }}
                  className="text-sm text-gray-600 hover:text-gray-900 font-medium transition-colors"
                >
                  Don't have an account? <span className="text-green-600">Sign up</span>
                </button>
              ) : (
                <button
                  onClick={() => {
                    setView('sign_in');
                    setMessage(null);
                  }}
                  className="text-sm text-gray-600 hover:text-gray-900 font-medium transition-colors"
                >
                  Already have an account? <span className="text-green-600">Sign in</span>
                </button>
              )}
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
