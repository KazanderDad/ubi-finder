




import { supabase } from "@/lib/supabaseClient";
import React, { useState, useEffect } from "react";
import { Link, useLocation } from "react-router-dom";
import { createPageUrl } from "@/utils";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { 
  LogOut, 
  Leaf, 
  User as UserIcon,
  FileText 
} from "lucide-react";

export default function TopNavBar({ user, userProfile }) {
  const [hasPrograms, setHasPrograms] = useState(false);
  const { pathname } = useLocation();

  useEffect(() => {
    if (user) {
      checkUserPrograms();
    }
  }, [user]);

  const checkUserPrograms = async () => {
    if (!user) {
      setHasPrograms(false);
      return;
    }

    try {
      // Only admins or users with program management rights should see this
      if (user.role === 'admin' || user.role === 'owner') {
        setHasPrograms(true);
        return;
      }

      // Check if user has any programs they can manage
      const managedPrograms = (await supabase.from('program_managers').select('*').match({ user_email: user.email })).data;
      // Verify we actually have results
      setHasPrograms(managedPrograms && managedPrograms.length > 0);
    } catch (error) {
      console.error("Error checking user programs:", error);
      setHasPrograms(false);
    }
  };

  const isActive = (path) => {
    return pathname === path;
  };

  const getButtonStyles = (path) => {
    if (isActive(path)) {
      return "bg-green-700 text-white hover:bg-green-800";
    }
    return "hover:bg-green-50 hover:text-green-700";
  };

  return (
    <header className="fixed top-0 z-50 w-full border-b bg-white/80 backdrop-blur-sm">
      <div className="container mx-auto flex h-16 items-center px-4">
        {/* Logo on left */}
        <div className="flex-shrink-0 mr-8">
          <Link 
            to="/" 
            className={`flex items-center space-x-2 transition-colors px-3 py-2 rounded-md ${
              isActive('/') ? 'bg-green-700 text-white' : 'hover:bg-green-50 hover:text-green-700'
            }`}
          >
            <Leaf className="h-6 w-6" />
            <span className="font-bold text-lg hidden sm:inline-block">
              UBI Finder
            </span>
          </Link>
        </div>

        {/* Center navigation */}
        <div className="flex-grow flex justify-center">
          <nav className="flex items-center gap-4">
            <Link 
              to="/Programs"
              className={`px-4 py-2 rounded-md text-sm font-medium transition-colors ${getButtonStyles('/Programs')}`}
            >
              Programs
            </Link>
            
            <Link 
              to="/Blog"
              className={`px-4 py-2 rounded-md text-sm font-medium transition-colors ${getButtonStyles('/Blog')}`}
            >
              Blog
            </Link>
            
            <Link 
              to="/About"
              className={`px-4 py-2 rounded-md text-sm font-medium transition-colors ${getButtonStyles('/About')}`}
            >
              About
            </Link>

            {user && (
              <Link 
                to="/Dashboard"
                className={`px-4 py-2 rounded-md text-sm font-medium border border-green-700 transition-colors ${
                  isActive('/Dashboard') 
                    ? 'bg-green-700 text-white' 
                    : 'text-green-700 hover:bg-green-50'
                }`}
              >
                My Dashboard
              </Link>
            )}
          </nav>
        </div>

        {/* User menu on right */}
        <div className="flex-shrink-0 ml-8">
          {user ? (
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button variant="ghost" className="relative h-10 w-10 rounded-full">
                  <Avatar className="h-10 w-10">
                    {userProfile?.profile_picture ? (
                      <AvatarImage src={userProfile.profile_picture} alt={user.full_name} />
                    ) : (
                      <AvatarFallback className="bg-green-100 text-green-700">
                        {user.full_name?.split(" ").map(n => n[0]).join("").toUpperCase()}
                      </AvatarFallback>
                    )}
                  </Avatar>
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent className="w-56" align="end">
                <DropdownMenuLabel className="font-normal">
                  <div className="flex flex-col space-y-1">
                    <p className="text-sm font-medium leading-none">{user.full_name}</p>
                    <p className="text-xs leading-none text-gray-500">{user.email}</p>
                  </div>
                </DropdownMenuLabel>
                <DropdownMenuSeparator />
                <Link to={createPageUrl("Profile")}>
                  <DropdownMenuItem className="cursor-pointer">
                    <UserIcon className="mr-2 h-4 w-4" />
                    <span>Profile</span>
                  </DropdownMenuItem>
                </Link>
                <Link to={createPageUrl("Dashboard")}>
                  <DropdownMenuItem className="cursor-pointer">
                    <Leaf className="mr-2 h-4 w-4" />
                    <span>Dashboard</span>
                  </DropdownMenuItem>
                </Link>
                {hasPrograms && (
                  <Link to={createPageUrl("My-Programs")}>
                    <DropdownMenuItem className="cursor-pointer">
                      <FileText className="mr-2 h-4 w-4" />
                      <span>Programs I Manage</span>
                    </DropdownMenuItem>
                  </Link>
                )}
                <DropdownMenuSeparator />
                <DropdownMenuItem
                  className="cursor-pointer text-red-600 hover:text-red-700 hover:bg-red-50"
                  onClick={() => User.logout()}
                >
                  <LogOut className="mr-2 h-4 w-4" />
                  <span>Log out</span>
                </DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          ) : (
            <Button 
              onClick={() => User.login()}
              className="bg-green-700 hover:bg-green-800"
            >
              Login
            </Button>
          )}
        </div>
      </div>
    </header>
  );
}

