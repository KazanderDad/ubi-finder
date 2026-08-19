





import React, { useState, useEffect } from "react";
import { useAuth } from "@/lib/AuthContext";
import { supabase } from "@/lib/supabaseClient";
import { createPageUrl } from "@/utils";
import { Link, useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { ArrowRight, Users, PlusCircle, Info } from "lucide-react";
import UserForm from "../components/UserForm";


export default function Home() {
  const { isAuthenticated, user } = useAuth();
  const [formData, setFormData] = useState(null);
  const navigate = useNavigate();
  const [lastScrollY, setLastScrollY] = useState(0);
  const [showHeader, setShowHeader] = useState(true);

  
  
  const handleFormSubmit = async (data) => {
    setFormData(data);
    if (!isAuthenticated) {
      localStorage.setItem("pendingProfile", JSON.stringify(data));
      window.location.href = '/login';
    } else {
      await supabase.from('user_profiles').insert([{ ...data, created_by_id: user.id }]);
      navigate("/Dashboard");
    }
  };

  useEffect(() => {
    const controlHeader = () => {
      const currentScrollY = window.scrollY;
      if (currentScrollY < lastScrollY || currentScrollY < 100) {
        setShowHeader(true);
      } else if (currentScrollY > 100 && currentScrollY > lastScrollY) {
        setShowHeader(false);
      }
      setLastScrollY(currentScrollY);
    };

    window.addEventListener('scroll', controlHeader);
    return () => window.removeEventListener('scroll', controlHeader);
  }, [lastScrollY]);

  return (
    <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50">
      
      
      {/* Add padding to account for fixed header */}
      <div>
        {/* Hero Section */}
        <section className="container mx-auto px-4 py-16 md:py-24">
          <div className="max-w-5xl mx-auto">
            <div className="flex flex-col md:flex-row items-center gap-10">
              <div className="md:w-1/2 text-center md:text-left">
                <h1 className="text-4xl md:text-5xl font-bold text-green-900 mb-6">
                  Find Income Support Programs
                </h1>
                <p className="text-xl text-green-800/80 mb-8">
                  Connect with verified programs offering regular income support. 
                  We help you discover opportunities available in your region.
                </p>
                <Button 
                  size="lg"
                  className="bg-green-700 hover:bg-green-800"
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
              
              <div className="md:w-1/2 flex justify-center mt-10 md:mt-0">
                <img 
                  src="https://qtrypzzcjebvfcihiynt.supabase.co/storage/v1/object/public/base44-prod/public/ca8fe7_ChatGPTImageApr28202501_40_09AM.png" 
                  alt="Person checking UBI eligibility checklist" 
                  className="max-w-full rounded-lg shadow-lg w-96"
                />
              </div>
            </div>
            
            <div className="mt-12 max-w-3xl mx-auto text-left bg-white/70 backdrop-blur-sm p-6 rounded-lg shadow-sm border border-green-100">
              <h2 className="text-2xl font-semibold text-green-900 mb-4">
                Unlock Your Universal Basic Income
              </h2>
              <p className="text-green-800/90 mb-4">
                Universal Basic Income (UBI) provides regular, unconditional cash payments to empower individuals and strengthen communities. UBI Finder instantly matches you with the right UBI initiatives in your region—both fiat and crypto-powered—so you can easily discover and claim the support you deserve.
              </p>
              <p className="text-green-800/90 mb-4">
                Simply tell us a bit about yourself, and we'll:
                <ul className="list-disc list-inside mt-2">
                  <li>Find programs you qualify for</li>
                  <li>Guide you step-by-step through each application</li>
                  <li>Alert you to new opportunities as they launch</li>
                </ul>
              </p>
              <p className="text-green-800/90">
                Join thousands who've turned a few clicks into real, ongoing cash support. Your journey to financial empowerment starts here—let's go!
              </p>
            </div>
          </div>
        </section>

        {/* Form Section */}
        <section id="user-form" className="container mx-auto px-4 py-16 bg-white rounded-lg shadow-lg">
          <div className="max-w-2xl mx-auto">
            <h2 className="text-3xl font-semibold text-center mb-8">
              Check Your Eligibility
            </h2>
            <UserForm onSubmit={handleFormSubmit} />
            {!isAuthenticated && (
              <div className="mt-6 text-center">
                <Link to="/Programs" className="text-sm font-medium text-green-600 hover:text-green-800 hover:underline">
                  Skip this, go direct to the Programs listing
                </Link>
              </div>
            )}
          </div>
        </section>

        {/* Decorative Image */}
        <div className="container mx-auto px-4">
          <div className="flex justify-center my-16">
            <img 
              src="https://qtrypzzcjebvfcihiynt.supabase.co/storage/v1/object/public/base44-prod/public/d14ef4_ubi-finder-woman-wide.png"
              alt="Happy woman with decorative elements"
              className="w-96 md:w-[500px] opacity-90"
            />
          </div>
        </div>

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
          <div className="grid md:grid-cols-3 gap-8">
            <div className="bg-white/80 backdrop-blur-sm p-6 rounded-lg shadow-lg text-center">
              <div className="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <Info className="w-6 h-6 text-green-700" />
              </div>
              <h3 className="text-xl font-semibold mb-3 text-green-900">Explore Programs</h3>
              <p className="text-green-800/80 mb-4">
                Browse through verified support programs available in your area.
              </p>
              <Link to={createPageUrl("Programs")}>
                <Button variant="outline" className="w-full border-green-600 text-green-700 hover:bg-green-50">
                  Learn More
                </Button>
              </Link>
            </div>

            <div className="bg-white/80 backdrop-blur-sm p-6 rounded-lg shadow-lg text-center">
              <div className="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <PlusCircle className="w-6 h-6 text-green-700" />
              </div>
              <h3 className="text-xl font-semibold mb-3 text-green-900">Submit a Program</h3>
              <p className="text-green-800/80 mb-4">
                Help others by adding a program to our database.
              </p>
              <Link to={createPageUrl("Submit-Program")}>
                <Button variant="outline" className="w-full border-green-600 text-green-700 hover:bg-green-50">
                  Add Program
                </Button>
              </Link>
            </div>

            <div className="bg-white/80 backdrop-blur-sm p-6 rounded-lg shadow-lg text-center">
              <div className="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <Users className="w-6 h-6 text-green-700" />
              </div>
              <h3 className="text-xl font-semibold mb-3 text-green-900">Community</h3>
              <p className="text-green-800/80 mb-4">
                Connect with others and share experiences.
              </p>
              <Link to={createPageUrl("Community")}>
                <Button variant="outline" className="w-full border-green-600 text-green-700 hover:bg-green-50">
                  Join
                </Button>
              </Link>
            </div>
          </div>
        </section>

         

         
      </div>
      
    </div>
  );
}

