





import { supabase } from "@/lib/supabaseClient";
import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { 
  FileEdit, 
  Settings, 
  AlertTriangle,
  Leaf 
} from "lucide-react";


export default function MyProgramsPage() {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(true);
  const [programs, setPrograms] = useState([]);
  const [user, setUser] = useState(null);

  useEffect(() => {
    window.scrollTo(0, 0);
    loadUserPrograms();
  }, []);

  const loadUserPrograms = async () => {
    try {
      // Get current user data
      const userData = (await supabase.auth.getUser()).data.user;
      if (!userData) {
        navigate("/"); // Redirect if not logged in
        return;
      }
      setUser(userData);

      // Get user's profile ID
      const profiles = (await supabase.from('user_profiles').select('*').match({ created_by: userData.email })).data;
      if (!profiles.length) {
        setLoading(false);
        return;
      }
      const userProfileId = profiles[0].id;

      // Get programs where user is a manager
      const managedPrograms = (await supabase.from('program_managers').select('*').match({ 
        user_email: userData.email,
        user_profile_id: userProfileId
      })).data;

      if (!managedPrograms.length) {
        setPrograms([]);
        setLoading(false);
        return;
      }

      // Filter for only owner/admin roles and get unique program IDs
      const programIds = [...new Set(
        managedPrograms
          .filter(m => m.role === "owner" || m.role === "admin")
          .map(m => m.program_id)
      )];

      if (!programIds.length) {
        setPrograms([]);
        setLoading(false);
        return;
      }

      // Get full program details
      const allPrograms = (await supabase.from('programs').select('*')).data;
      const accessiblePrograms = allPrograms.filter(p => 
        programIds.includes(p.program_id)
      );

      setPrograms(accessiblePrograms);
      setLoading(false);
    } catch (error) {
      console.error("Error loading programs:", error);
      setLoading(false);
      navigate("/Programs");
    }
  };

  const handleWriteBlog = (program) => {
    navigate("/Write-Blog", { state: { program } });
  };

  const handleManageProgram = (programId) => {
    navigate("/Manage-Program", { state: { programId } });
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
      <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-12">
        <div className="max-w-5xl mx-auto">
          <div className="text-center mb-8">
            <div className="inline-block p-2 bg-green-100 rounded-full mb-4">
              <Leaf className="w-8 h-8 text-green-700" />
            </div>
            <h1 className="text-3xl font-bold text-green-900">My Programs</h1>
            <p className="text-lg text-green-700 mt-2">
              Manage your UBI programs and create blog posts
            </p>
          </div>

          {programs.length === 0 ? (
            <Card>
              <CardContent className="text-center py-12">
                <p className="text-gray-500 mb-4">You don't have any programs to manage yet.</p>
                <Button 
                  onClick={() => navigate("/Submit-Program")}
                  className="bg-green-700 hover:bg-green-800"
                >
                  Submit Your First Program
                </Button>
              </CardContent>
            </Card>
          ) : (
            <div className="space-y-6">
              {programs.map(program => (
                <Card 
                  key={program.id} 
                  className="overflow-hidden hover:shadow-lg transition-all duration-300 transform hover:-translate-y-1"
                >
                  <CardContent className="p-6">
                    <div className="flex flex-col md:flex-row justify-between gap-6">
                      <div className="flex-1">
                        <div className="flex items-start justify-between">
                          <div>
                            <h3 className="text-xl font-bold text-green-800 mb-1">
                              {program.name}
                            </h3>
                            <p className="text-sm text-gray-600 mb-2">
                              By {program.organization}
                            </p>
                          </div>
                        </div>
                        
                        <div className="flex flex-wrap gap-2 my-2">
                          <Badge className={program.status === 'active_open' 
                            ? 'bg-green-100 text-green-800' 
                            : program.status === 'active_closed'
                            ? 'bg-orange-100 text-orange-800'
                            : program.status === 'upcoming'
                            ? 'bg-blue-100 text-blue-800'
                            : 'bg-gray-100 text-gray-800'
                          }>
                            {program.status === 'active_open' ? 'Active • Open' : 
                             program.status === 'active_closed' ? 'Active • Closed' : 
                             program.status === 'upcoming' ? 'Upcoming' : 'Closed'}
                          </Badge>
                          
                          <Badge className={program.payment_method === 'digital' 
                            ? 'bg-purple-100 text-purple-800' 
                            : 'bg-blue-100 text-blue-800'}>
                            {program.payment_method === 'digital' ? 'Digital Payment' : 'Standard Payment'}
                          </Badge>
                          
                          {!program.verified && (
                            <Badge className="bg-amber-100 text-amber-800 flex items-center gap-1">
                              <AlertTriangle className="w-3 h-3" />
                              Not Yet Reviewed
                            </Badge>
                          )}
                        </div>
                        
                        <p className="text-gray-700 mt-3">
                          {program.description.length > 150 
                            ? `${program.description.slice(0, 150)}...` 
                            : program.description}
                        </p>
                      </div>
                      
                      <div className="flex flex-col gap-3 min-w-[200px]">
                        <Button 
                          onClick={() => handleManageProgram(program.program_id)}
                          className="w-full bg-blue-600 hover:bg-blue-700"
                        >
                          <Settings className="w-4 h-4 mr-2" />
                          Manage Program
                        </Button>
                        <Button 
                          onClick={() => handleWriteBlog(program)}
                          variant="outline"
                          className="w-full border-green-600 text-green-700 hover:bg-green-50"
                        >
                          <FileEdit className="w-4 h-4 mr-2" />
                          Write Blog Post
                        </Button>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </div>
      </div>
      
    </>
  );
}

