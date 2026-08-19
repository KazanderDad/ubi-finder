





import { supabase } from "@/lib/supabaseClient";
import React, { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Separator } from "@/components/ui/separator";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Label } from "@/components/ui/label";
import { Avatar, AvatarImage, AvatarFallback } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { Leaf, ChevronLeft, Edit, CreditCard, Wallet } from "lucide-react";
import { useNavigate } from "react-router-dom";
import { createPageUrl } from "@/utils";
import { Link } from "react-router-dom";


// Default avatar image to use when user has no profile picture
const DEFAULT_AVATAR = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScfYIGxbXeB6QQNQ6juhTxDVvfc1850IBMtQ&s";

export default function Profile() {
  const [user, setUser] = useState(null);
  const [userProfile, setUserProfile] = useState(null);
  const [bankAccounts, setBankAccounts] = useState([]);
  const [cryptoWallets, setCryptoWallets] = useState([]);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  const BLOCKCHAINS = [
    { value: "ethereum", label: "Ethereum (ETH)" },
    { value: "bitcoin", label: "Bitcoin (BTC)" },
    { value: "solana", label: "Solana (SOL)" },
    { value: "polygon", label: "Polygon (MATIC)" },
    { value: "avalanche", label: "Avalanche (AVAX)" },
    { value: "binance_smart_chain", label: "BNB Chain (BNB)" },
    { value: "other", label: "Other" }
  ];

  useEffect(() => {
    loadUserData();
  }, []);

  const loadUserData = async () => {
    try {
      const userData = (await supabase.auth.getUser()).data.user;
      setUser(userData);

      const profiles = (await supabase.from('user_profiles').select('*').match({ created_by: userData.email })).data;
      if (profiles.length > 0) {
        const profile = profiles[0];
        console.log("Found profile:", profile); // Debug full profile
        console.log("Profile picture URL:", profile.profile_picture); // Debug just the picture
        
        setUserProfile(profile);
        
        // Load bank accounts and crypto wallets
        const accounts = (await supabase.from('bank_accounts').select('*').match({ user_profile_id: profile.id })).data;
        const wallets = (await supabase.from('crypto_wallets').select('*').match({ user_profile_id: profile.id })).data;
        setBankAccounts(accounts);
        setCryptoWallets(wallets);
      }

      setLoading(false);
    } catch (error) {
      console.error("Error loading user data:", error);
      navigate(createPageUrl("Home"));
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-green-700"></div>
      </div>
    );
  }

  return (
    <>
      <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-8">
        <div className="max-w-3xl mx-auto">
          <div className="flex justify-between items-center mb-6">
            <Button 
              variant="ghost" 
              className="text-green-700"
              onClick={() => navigate(createPageUrl("Dashboard"))}
            >
              <ChevronLeft className="w-5 h-5 mr-1" />
              Back to Dashboard
            </Button>
            <Link to={createPageUrl("EditProfile")}>
              <Button
                className="bg-green-700 hover:bg-green-800"
              >
                <Edit className="w-4 h-4 mr-2" />
                Edit Profile
              </Button>
            </Link>
          </div>

          <div className="text-center mb-8">
            <div className="inline-block p-2 bg-green-100 rounded-full mb-4">
              <Leaf className="w-8 h-8 text-green-700" />
            </div>
            <h1 className="text-2xl font-bold text-green-900">My Profile</h1>
            <p className="text-green-700 mt-2">Your personal information and preferences</p>
          </div>
          
          <Separator className="my-6" />
          
          {/* Profile Picture Card */}
          <Card className="shadow-lg mb-8">
            <CardHeader>
              <CardTitle>Profile Picture</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="flex flex-col items-center">
                <Avatar className="h-24 w-24 mb-4">
                  {userProfile?.profile_picture ? (
                    <AvatarImage src={userProfile.profile_picture} alt="Profile" />
                  ) : (
                    <AvatarImage 
                      src={DEFAULT_AVATAR} 
                      alt="Default avatar"
                      fallback={
                        <AvatarFallback className="bg-green-100 text-green-700 text-xl">
                          {user?.full_name?.split(" ").map(n => n[0]).join("").toUpperCase()}
                        </AvatarFallback>
                      }
                    />
                  )}
                </Avatar>
                <h3 className="text-lg font-medium text-green-900">{user?.full_name}</h3>
              </div>
            </CardContent>
          </Card>

          {/* Profile Details Card */}
          <Card className="shadow-lg mb-8">
            <CardHeader>
              <CardTitle>Personal Information</CardTitle>
            </CardHeader>
            <CardContent className="space-y-6">
              <div>
                <Label>Full Name</Label>
                <p className="text-green-900 mt-1">{userProfile?.name}</p>
              </div>

              <div>
                <Label>Gender</Label>
                <p className="text-green-900 mt-1">
                  {userProfile?.gender === "abstain" 
                    ? "Abstaining from gender-specific programs"
                    : userProfile?.gender === "female"
                    ? "Female"
                    : userProfile?.gender === "male"
                    ? "Male"
                    : "Not specified"}
                </p>
              </div>

              <div>
                <Label>Location</Label>
                <p className="text-green-900 mt-1">
                  {userProfile?.state ? `${userProfile.state}, ${userProfile.country}` : userProfile?.country}
                </p>
              </div>

              <div>
                <Label>Currency</Label>
                <p className="text-green-900 mt-1">
                  {userProfile?.currency || "USD"}
                </p>
              </div>

              <div>
                <Label>Household Size</Label>
                <p className="text-green-900 mt-1">{userProfile?.household_size} people</p>
              </div>

              <div>
                <Label>Annual Household Income</Label>
                <p className="text-green-900 mt-1">{userProfile?.income_range}</p>
              </div>



              <div>
                <Label>Payment Preferences</Label>
                <div className="mt-2 space-y-2">
                  <div className="flex items-center gap-2">
                    <Badge variant={userProfile?.accepts_digital_currency ? "default" : "outline"}>
                      Digital Currency
                    </Badge>
                    <span className="text-sm text-green-700">
                      {userProfile?.accepts_digital_currency ? "Accepted" : "Not accepted"}
                    </span>
                  </div>
                  <div className="flex items-center gap-2">
                    <Badge variant={userProfile?.accepts_foreign_currency ? "default" : "outline"}>
                      Foreign Currency
                    </Badge>
                    <span className="text-sm text-green-700">
                      {userProfile?.accepts_foreign_currency ? "Accepted" : "Not accepted"}
                    </span>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>

          {/* Bank Accounts Card */}
          <Card className="shadow-lg mb-8">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <CreditCard className="w-5 h-5 text-green-700" />
                Bank Accounts
              </CardTitle>
            </CardHeader>
            <CardContent>
              {bankAccounts.length === 0 ? (
                <p className="text-gray-500 text-center py-4">No bank accounts added yet</p>
              ) : (
                <div className="space-y-4">
                  {bankAccounts.map(account => (
                    <div 
                      key={account.id} 
                      className={`p-4 border rounded-lg ${account.is_primary ? 'border-green-600 bg-green-50' : ''}`}
                    >
                      <div className="flex justify-between items-start">
                        <div>
                          <div className="flex items-center">
                            <h3 className="font-medium text-green-900">{account.bank_name}</h3>
                            {account.is_primary && (
                              <Badge className="ml-2 bg-green-600">Primary</Badge>
                            )}
                          </div>
                          <p className="text-sm text-gray-600">
                            {account.account_holder_name} &middot; {account.country}
                          </p>
                          <p className="text-sm text-gray-600 mt-1">
                            Account: ••••{account.account_number.slice(-4)}
                          </p>
                          {account.routing_number && (
                            <p className="text-sm text-gray-600">
                              Routing: ••••{account.routing_number.slice(-4)}
                            </p>
                          )}
                          {account.iban && (
                            <p className="text-sm text-gray-600">
                              IBAN: ••••{account.iban.slice(-4)}
                            </p>
                          )}
                          {account.swift_code && (
                            <p className="text-sm text-gray-600">
                              SWIFT: {account.swift_code}
                            </p>
                          )}
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              )}
            </CardContent>
          </Card>

          {/* Crypto Wallets Card */}
          <Card className="shadow-lg mb-8">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Wallet className="w-5 h-5 text-green-700" />
                Crypto Wallets
              </CardTitle>
            </CardHeader>
            <CardContent>
              {cryptoWallets.length === 0 ? (
                <p className="text-gray-500 text-center py-4">No crypto wallets added yet</p>
              ) : (
                <div className="space-y-4">
                  {cryptoWallets.map(wallet => {
                    const blockchainName = wallet.blockchain === "other" 
                      ? wallet.other_blockchain 
                      : BLOCKCHAINS.find(b => b.value === wallet.blockchain)?.label || wallet.blockchain;
                      
                    return (
                      <div 
                        key={wallet.id} 
                        className={`p-4 border rounded-lg ${wallet.is_primary ? 'border-green-600 bg-green-50' : ''}`}
                      >
                        <div className="flex justify-between items-start">
                          <div>
                            <div className="flex items-center">
                              <h3 className="font-medium text-green-900">
                                {wallet.wallet_name || blockchainName}
                              </h3>
                              {wallet.is_primary && (
                                <Badge className="ml-2 bg-green-600">Primary</Badge>
                              )}
                            </div>
                            {!wallet.wallet_name && (
                              <p className="text-sm text-gray-600">
                                {blockchainName}
                              </p>
                            )}
                            <p className="text-sm text-gray-600 mt-1 font-mono">
                              {wallet.public_key.length > 16 
                                ? `${wallet.public_key.slice(0, 8)}...${wallet.public_key.slice(-8)}`
                                : wallet.public_key
                              }
                            </p>
                          </div>
                        </div>
                      </div>
                    );
                  })}
                </div>
              )}
            </CardContent>
          </Card>
        </div>
      </div>
      
    </>
  );
}

