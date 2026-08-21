import React, { useState, useEffect } from "react";
import { useAuth } from "@/lib/AuthContext";
import { supabase } from "@/lib/supabaseClient";
import { createPageUrl } from "@/utils";
import { Link, useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { ArrowRight, Users, PlusCircle, Info, Sparkles, Globe, DollarSign, ExternalLink } from "lucide-react";
import UserForm from "../components/UserForm";
import SupportWidget from "../components/SupportWidget";

import { Helmet } from "react-helmet-async";

export default function Home() {
  const { isAuthenticated, user } = useAuth();
  const [formData, setFormData] = useState(null);
  const [featuredPrograms, setFeaturedPrograms] = useState([]);
  const [loadingFeatured, setLoadingFeatured] = useState(true);
  const navigate = useNavigate();

  const organizationSchema = {
    "@context": "https://schema.org",
    "@type": "Organization",
    "name": "UBI Finder",
    "url": "https://ubifinder.org",
    "logo": "https://ubifinder.org/leaf.png",
    "description": "Connecting individuals with verified Universal Basic Income and income support programs worldwide."
  };

  useEffect(() => {
    const fetchFeatured = async () => {
      try {
        const { data, error } = await supabase
          .from('programs')
          .select('*')
          .neq('internal_status', 'deleted')
          .limit(4);
        if (!error && data) {
          setFeaturedPrograms(data.filter(p => p.internal_status !== 'deleted'));
        }
      } catch (err) {
        console.error("Error loading featured programs:", err);
      } finally {
        setLoadingFeatured(false);
      }
    };
    fetchFeatured();
  }, []);

  const handleFormSubmit = async (data) => {
    setFormData(data);
    if (isAuthenticated && user) {
      navigate("/My-Report");
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50">
      <Helmet>
        <title>UBI Finder — Universal Basic Income Programs & Cash Grants</title>
        <meta name="description" content="Discover and qualify for verified Universal Basic Income (UBI) and guaranteed income initiatives in your country." />
        <script type="application/ld+json">
          {JSON.stringify(organizationSchema)}
        </script>
      </Helmet>
      <div>
        {/* Hero Section */}
        <section className="container mx-auto px-4 py-16 md:py-24">
          <div className="max-w-5xl mx-auto">
            <div className="flex flex-col md:flex-row items-center gap-10">
              <div className="md:w-1/2 text-center md:text-left">
                <div className="inline-flex items-center gap-2 px-3 py-1 bg-green-100/80 border border-green-200 rounded-full text-xs font-semibold text-green-800 mb-4">
                  <Sparkles className="w-3.5 h-3.5 text-green-700" />
                  Verified Cash & Digital Support Directory
                </div>
                <h1 className="text-4xl md:text-5xl font-bold text-green-900 mb-6 leading-tight">
                  Find Income Support Programs
                </h1>
                <p className="text-xl text-green-800/80 mb-8">
                  Connect with verified programs offering regular income support. 
                  We help you discover opportunities available in your region.
                </p>
                <div className="flex flex-col sm:flex-row items-center justify-center md:justify-start gap-4">
                  <Button 
                    size="lg"
                    className="bg-green-700 hover:bg-green-800 w-full sm:w-auto shadow-md"
                    onClick={() => {
                      document.getElementById('user-form').scrollIntoView({ 
                        behavior: 'smooth' 
                      });
                    }}
                  >
                    Find Programs
                    <ArrowRight className="ml-2 w-5 h-5" />
                  </Button>
                </div>
                
                {/* 1b. Split Hero Messaging for Builders / Managers */}
                <div className="mt-5 text-sm text-green-800/90 flex items-center justify-center md:justify-start gap-2">
                  <span>Launching or managing a UBI program?</span>
                  <Link to="/Services" className="font-semibold text-green-700 hover:text-green-900 underline flex items-center gap-1">
                    Explore Builder Services &rarr;
                  </Link>
                </div>
              </div>
              
              <div className="md:w-1/2 flex justify-center mt-10 md:mt-0">
                <img 
                  src="https://qtrypzzcjebvfcihiynt.supabase.co/storage/v1/object/public/base44-prod/public/ca8fe7_ChatGPTImageApr28202501_40_09AM.png" 
                  alt="Person checking UBI eligibility checklist" 
                  className="max-w-full rounded-2xl shadow-xl w-96 border-4 border-white/80"
                />
              </div>
            </div>
            
            <div className="mt-12 max-w-3xl mx-auto text-left bg-white/70 backdrop-blur-md p-6 rounded-2xl shadow-sm border border-green-100">
              <h2 className="text-2xl font-semibold text-green-900 mb-4">
                Unlock Your Universal Basic Income
              </h2>
              <p className="text-green-800/90 mb-4">
                Universal Basic Income (UBI) provides regular, unconditional cash payments to empower individuals and strengthen communities. UBI Finder instantly matches you with the right UBI initiatives in your region—both fiat and crypto-powered—so you can easily discover and claim the support you deserve.
              </p>
              <div className="text-green-800/90 mb-4">
                Simply tell us a bit about yourself, and we'll:
                <ul className="list-disc list-inside mt-2 space-y-1">
                  <li>Find programs you qualify for</li>
                  <li>Guide you step-by-step through each application</li>
                  <li>Alert you to new opportunities as they launch</li>
                </ul>
              </div>
              <p className="text-green-800/90">
                Join thousands who've turned a few clicks into real, ongoing cash support. Your journey to financial empowerment starts here—let's go!
              </p>
            </div>
          </div>
        </section>

        {/* Form Section */}
        <section id="user-form" className="container mx-auto px-4 py-16 bg-white/90 backdrop-blur-sm rounded-2xl shadow-xl border border-green-100 max-w-3xl">
          <div>
            <h2 className="text-3xl font-semibold text-center text-green-900 mb-2">
              Check Your Eligibility
            </h2>
            <p className="text-center text-gray-600 text-sm mb-8">
              Answer a few quick questions to receive your tailored program matches.
            </p>
            <UserForm onSubmit={handleFormSubmit} />
            {!isAuthenticated && (
              <div className="mt-6 text-center">
                <Link to="/Programs" className="text-sm font-medium text-green-600 hover:text-green-800 hover:underline">
                  Skip this, go direct to the Programs listing &rarr;
                </Link>
              </div>
            )}
          </div>
        </section>

        {/* 1c. Live Featured Programs Strip (Replaces decorative image) */}
        <section className="container mx-auto px-4 my-20">
          <div className="max-w-5xl mx-auto">
            <div className="flex flex-col md:flex-row md:items-end justify-between mb-8 gap-4">
              <div>
                <span className="text-xs font-bold uppercase tracking-wider text-green-600">Explore Opportunities</span>
                <h2 className="text-3xl font-bold text-green-900 mt-1">Featured Programs</h2>
                <p className="text-gray-600 text-sm mt-1">
                  Discover actively funding and ongoing basic income initiatives.
                </p>
              </div>
              <Link to="/Programs">
                <Button variant="outline" className="border-green-600 text-green-700 hover:bg-green-50">
                  View All Programs &rarr;
                </Button>
              </Link>
            </div>

            {loadingFeatured ? (
              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                {[1, 2, 3, 4].map(i => (
                  <div key={i} className="bg-white rounded-xl p-5 shadow border border-gray-100 animate-pulse space-y-3">
                    <div className="h-4 bg-gray-200 rounded w-2/3"></div>
                    <div className="h-8 bg-gray-100 rounded"></div>
                    <div className="h-4 bg-gray-200 rounded w-1/2"></div>
                  </div>
                ))}
              </div>
            ) : (
              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                {featuredPrograms.map(program => (
                  <Card 
                    key={program.id}
                    onClick={() => navigate(`/program-details`, { state: { programId: program.program_id } })}
                    className="hover:-translate-y-1 hover:shadow-xl transition-all duration-200 cursor-pointer bg-white/80 backdrop-blur-sm border-green-100 flex flex-col justify-between"
                  >
                    <CardContent className="p-5">
                      <div className="flex items-center justify-between mb-2">
                        <Badge className="bg-green-100 text-green-800 text-xs font-medium">
                          {program.payment_method === 'digital' ? 'Digital UBI' : 'Cash UBI'}
                        </Badge>
                        {program.application_status && (
                          <span className="text-[11px] text-gray-500 font-medium">
                            {program.application_status.includes('Accepting') ? '🟢 Open' : '🟡 ' + program.application_status}
                          </span>
                        )}
                      </div>
                      
                      <h3 className="font-bold text-green-950 text-base line-clamp-1 mb-1">{program.name}</h3>
                      <p className="text-xs text-gray-500 line-clamp-1 mb-3">{program.organization}</p>
                      
                      <div className="bg-green-50/80 rounded-lg p-2.5 mb-3 border border-green-100">
                        <div className="text-xs text-green-800 font-medium">Est. Monthly Support</div>
                        <div className="text-lg font-bold text-green-900">
                          ${Number(program.monthly_amount_usd || 0).toLocaleString()} <span className="text-xs font-normal text-gray-600">USD</span>
                        </div>
                      </div>

                      <div className="flex items-center gap-1.5 text-xs text-gray-600">
                        <Globe className="w-3.5 h-3.5 text-green-600 flex-shrink-0" />
                        <span className="truncate">
                          {program.available_regions?.length > 0 ? program.available_regions.join(", ") : "Global"}
                        </span>
                      </div>
                    </CardContent>
                  </Card>
                ))}
              </div>
            )}
          </div>
        </section>

        {/* CTA Introduction */}
        <div className="container mx-auto px-4 mb-16">
          <div className="max-w-3xl mx-auto text-center">
            <h2 className="text-3xl font-bold text-green-900 mb-4">
              Your Journey to Financial Freedom
            </h2>
            <p className="text-xl text-green-800/80 mb-8">
              Take the next step toward securing your financial future. Whether you're looking to explore available programs, 
              contribute to our growing database, or connect with others on similar journeys - we're here to help you succeed.
            </p>
          </div>
        </div>

        {/* Features Grid */}
        <section className="container mx-auto px-4 py-16">
          <div className="grid md:grid-cols-3 gap-8 max-w-5xl mx-auto">
            <div className="bg-white/80 backdrop-blur-sm p-6 rounded-2xl shadow-lg border border-green-100 text-center hover:-translate-y-1 transition-all duration-200">
              <div className="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <Info className="w-6 h-6 text-green-700" />
              </div>
              <h3 className="text-xl font-semibold mb-3 text-green-900">Explore Programs</h3>
              <p className="text-green-800/80 mb-4 text-sm">
                Browse through verified support programs available in your area.
              </p>
              <Link to={createPageUrl("Programs")}>
                <Button variant="outline" className="w-full border-green-600 text-green-700 hover:bg-green-50">
                  Learn More
                </Button>
              </Link>
            </div>

            <div className="bg-white/80 backdrop-blur-sm p-6 rounded-2xl shadow-lg border border-green-100 text-center hover:-translate-y-1 transition-all duration-200">
              <div className="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <PlusCircle className="w-6 h-6 text-green-700" />
              </div>
              <h3 className="text-xl font-semibold mb-3 text-green-900">Submit a Program</h3>
              <p className="text-green-800/80 mb-4 text-sm">
                Help others by adding a program to our growing database.
              </p>
              <Link to={isAuthenticated ? "/Submit-Program" : "/login?view=signup&redirectTo=/Submit-Program"}>
                <Button variant="outline" className="w-full border-green-600 text-green-700 hover:bg-green-50">
                  Add Program
                </Button>
              </Link>
            </div>

            <div className="bg-white/80 backdrop-blur-sm p-6 rounded-2xl shadow-lg border border-green-100 text-center hover:-translate-y-1 transition-all duration-200">
              <div className="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <Users className="w-6 h-6 text-green-700" />
              </div>
              <h3 className="text-xl font-semibold mb-3 text-green-900">Community Hub</h3>
              <p className="text-green-800/80 mb-4 text-sm">
                Connect with others and share experiences in our community forum.
              </p>
              <Link to={createPageUrl("Community")}>
                <Button variant="outline" className="w-full border-green-600 text-green-700 hover:bg-green-50">
                  Join Forum
                </Button>
              </Link>
            </div>
          </div>
        </section>

        {/* Support This Project Section */}
        <section className="container mx-auto px-4 py-16">
          <div className="max-w-5xl mx-auto">
            <SupportWidget />
          </div>
        </section>
      </div>
    </div>
  );
}
