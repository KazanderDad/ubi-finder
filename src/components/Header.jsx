import React, { useState, useEffect } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
import { useAuth } from "@/lib/AuthContext";
import { Button } from "@/components/ui/button";
import { 
  Leaf, 
  Menu, 
  X, 
  User as UserIcon, 
  LayoutDashboard, 
  Briefcase, 
  Settings, 
  LogOut, 
  ChevronDown,
  Sparkles,
  Layers
} from "lucide-react";
import { 
  DropdownMenu, 
  DropdownMenuTrigger, 
  DropdownMenuContent, 
  DropdownMenuItem, 
  DropdownMenuSeparator,
  DropdownMenuGroup 
} from "@/components/ui/dropdown-menu";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import UserForm from "@/components/UserForm";

export default function Header() {
  const { user, signOut } = useAuth();
  const [isScrolled, setIsScrolled] = useState(false);
  const [isVisible, setIsVisible] = useState(true);
  const [lastScrollY, setLastScrollY] = useState(0);
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const location = useLocation();
  const navigate = useNavigate();
  const [eligibilityModalOpen, setEligibilityModalOpen] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      const currentScrollY = window.scrollY;
      
      if (currentScrollY > 10) {
        setIsScrolled(true);
      } else {
        setIsScrolled(false);
      }

      if (currentScrollY > lastScrollY && currentScrollY > 100) {
        setIsVisible(false);
      } else {
        setIsVisible(true);
      }

      setLastScrollY(currentScrollY);
    };

    window.addEventListener("scroll", handleScroll, { passive: true });
    return () => window.removeEventListener("scroll", handleScroll);
  }, [lastScrollY]);

  useEffect(() => {
    setMobileMenuOpen(false);
  }, [location]);

  const handleProgramsClick = (e) => {
    if (user) return;
    
    e.preventDefault();
    setMobileMenuOpen(false);

    const isPrograms = location.pathname.toLowerCase() === '/programs';
    if (isPrograms) return;

    const isHome = location.pathname === '/' || location.pathname === '/Home';
    
    if (isHome) {
      const formEl = document.getElementById('user-form');
      if (formEl) {
        formEl.scrollIntoView({ behavior: 'smooth' });
      }
    } else {
      setEligibilityModalOpen(true);
    }
  };

  const handleModalFormSubmit = (data) => {
    localStorage.setItem("pendingProfile", JSON.stringify(data));
    window.location.href = '/login?view=signup';
  };

  const navLinks = [
    { name: "Programs", path: "/Programs" },
    { name: "Community", path: "/Community" },
    { name: "Blog", path: "/Blog" },
    { name: "For Builders", path: "/Services", badge: "New" },
    { name: "About", path: "/About" }
  ];

  const renderDesktopNav = () => (
    <nav className="hidden md:flex items-center space-x-6">
      {navLinks.map((link) => {
        const isActive = location.pathname.toLowerCase() === link.path.toLowerCase();
        const activeClass = isActive 
          ? 'text-green-800 font-bold' 
          : 'text-gray-600 hover:text-green-700 font-medium';

        if (link.name === 'Programs' && !user) {
          return (
            <a 
              key={link.name} 
              href={link.path}
              onClick={handleProgramsClick}
              className={`text-sm transition-colors cursor-pointer flex items-center gap-1 ${activeClass}`}
            >
              {link.name}
            </a>
          );
        }
        return (
          <Link 
            key={link.name} 
            to={link.path}
            className={`text-sm transition-colors flex items-center gap-1.5 ${activeClass}`}
          >
            {link.name}
            {link.badge && (
              <span className="text-[10px] uppercase font-bold text-green-800 bg-green-100 px-1.5 py-0.2 rounded-full">
                {link.badge}
              </span>
            )}
          </Link>
        );
      })}

      {/* 9a. Authenticated User Dropdown Menu */}
      {user ? (
        <div className="flex items-center space-x-3 border-l pl-5 border-gray-200">
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <button className="flex items-center gap-2 p-1.5 rounded-full hover:bg-gray-100 transition-colors focus:outline-none">
                <Avatar className="h-8 w-8 border border-green-300">
                  <AvatarFallback className="bg-green-700 text-white font-bold text-xs">
                    {user.email ? user.email.slice(0, 2).toUpperCase() : "U"}
                  </AvatarFallback>
                </Avatar>
                <span className="text-xs font-semibold text-gray-700 max-w-[120px] truncate hidden lg:inline">
                  {user.email?.split('@')[0]}
                </span>
                <ChevronDown className="w-3.5 h-3.5 text-gray-400" />
              </button>
            </DropdownMenuTrigger>
            
            <DropdownMenuContent align="end" className="w-52 bg-white/95 backdrop-blur-md shadow-xl border-gray-200">
              <div className="p-2 border-b border-gray-100 text-xs">
                <p className="font-semibold text-gray-900 truncate">{user.email}</p>
                <p className="text-gray-400 text-[11px]">Member</p>
              </div>

              <DropdownMenuGroup className="p-1">
                <DropdownMenuItem 
                  onClick={() => navigate("/Dashboard")}
                  className="cursor-pointer text-xs font-medium flex items-center gap-2 p-2 hover:bg-green-50"
                >
                  <LayoutDashboard className="w-4 h-4 text-green-700" />
                  My Dashboard
                </DropdownMenuItem>

                <DropdownMenuItem 
                  onClick={() => navigate("/My-Programs")}
                  className="cursor-pointer text-xs font-medium flex items-center gap-2 p-2 hover:bg-green-50"
                >
                  <Briefcase className="w-4 h-4 text-green-700" />
                  Managed Programs
                </DropdownMenuItem>

                <DropdownMenuItem 
                  onClick={() => navigate("/Profile")}
                  className="cursor-pointer text-xs font-medium flex items-center gap-2 p-2 hover:bg-green-50"
                >
                  <Settings className="w-4 h-4 text-green-700" />
                  Profile Settings
                </DropdownMenuItem>
              </DropdownMenuGroup>

              <DropdownMenuSeparator />

              <DropdownMenuItem 
                onClick={signOut}
                className="cursor-pointer text-xs font-semibold text-red-600 flex items-center gap-2 p-2 hover:bg-red-50"
              >
                <LogOut className="w-4 h-4" />
                Sign Out
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>
        </div>
      ) : (
        <div className="flex items-center space-x-3 border-l pl-5 border-gray-200">
          <Link to="/login">
            <Button variant="ghost" size="sm" className="text-xs font-semibold text-gray-700 hover:text-green-800">
              Sign In
            </Button>
          </Link>
          <Link to="/login?view=signup">
            <Button size="sm" className="bg-green-700 hover:bg-green-800 text-white font-semibold text-xs px-4 shadow-sm">
              Get Started
            </Button>
          </Link>
        </div>
      )}
    </nav>
  );

  const renderMobileNav = () => (
    <div className={`md:hidden absolute top-16 left-0 w-full bg-white shadow-xl border-t border-gray-100 transition-all duration-300 ease-in-out ${mobileMenuOpen ? 'opacity-100 visible h-auto' : 'opacity-0 invisible h-0 overflow-hidden'}`}>
      <div className="flex flex-col p-4 space-y-3 text-sm">
        {navLinks.map((link) => {
          const isActive = location.pathname.toLowerCase() === link.path.toLowerCase();
          const activeClass = isActive ? 'text-green-700 font-bold' : 'text-gray-800 hover:text-green-700';

          if (link.name === 'Programs' && !user) {
            return (
              <a 
                key={link.name} 
                href={link.path}
                onClick={handleProgramsClick}
                className={`py-2 border-b border-gray-50 cursor-pointer block ${activeClass}`}
              >
                {link.name}
              </a>
            );
          }
          return (
            <Link 
              key={link.name} 
              to={link.path}
              className={`py-2 border-b border-gray-50 flex items-center justify-between ${activeClass}`}
            >
              <span>{link.name}</span>
              {link.badge && (
                <span className="text-[10px] uppercase font-bold text-green-800 bg-green-100 px-2 py-0.5 rounded-full">
                  {link.badge}
                </span>
              )}
            </Link>
          );
        })}

        {user ? (
          <>
            <div className="pt-3 pb-1 border-t border-gray-100">
              <p className="text-[11px] font-bold text-gray-400 uppercase tracking-wider">Account ({user.email})</p>
            </div>
            <Link to="/Dashboard" className="py-2 border-b border-gray-50 flex items-center gap-2 text-gray-800 font-medium">
              <LayoutDashboard className="w-4 h-4 text-green-700" />
              My Dashboard
            </Link>
            <Link to="/My-Programs" className="py-2 border-b border-gray-50 flex items-center gap-2 text-gray-800 font-medium">
              <Briefcase className="w-4 h-4 text-green-700" />
              Managed Programs
            </Link>
            <Link to="/Profile" className="py-2 border-b border-gray-50 flex items-center gap-2 text-gray-800 font-medium">
              <Settings className="w-4 h-4 text-green-700" />
              Profile Settings
            </Link>
            <button 
              onClick={signOut}
              className="text-left text-sm font-semibold text-red-600 py-2 flex items-center gap-2"
            >
              <LogOut className="w-4 h-4" />
              Sign Out
            </button>
          </>
        ) : (
          <div className="flex flex-col space-y-2 pt-3 border-t border-gray-100">
            <Link to="/login" className="w-full">
              <Button variant="outline" className="w-full border-green-600 text-green-700">
                Sign In
              </Button>
            </Link>
            <Link to="/login?view=signup" className="w-full">
              <Button className="w-full bg-green-700 hover:bg-green-800">
                Get Started
              </Button>
            </Link>
          </div>
        )}
      </div>
    </div>
  );

  return (
    <header 
      className={`fixed top-0 left-0 right-0 z-50 bg-white/90 backdrop-blur-md transition-all duration-300 ease-in-out ${
        isVisible ? 'translate-y-0' : '-translate-y-full'
      } ${isScrolled ? 'shadow-sm border-b border-gray-200' : 'border-b border-transparent'}`}
    >
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center h-16">
          {/* Logo */}
          <div className="flex-shrink-0 flex items-center">
            <Link to="/" className="flex items-center gap-2">
              <Leaf className="h-7 w-7 text-green-600" />
              <span className="font-bold text-xl text-green-950 tracking-tight">UBI Finder</span>
            </Link>
          </div>

          {/* Desktop Navigation */}
          {renderDesktopNav()}

          {/* Mobile menu button */}
          <div className="md:hidden flex items-center">
            <button
              onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
              className="text-gray-500 hover:text-green-700 focus:outline-none p-2"
            >
              {mobileMenuOpen ? (
                <X className="h-6 w-6" />
              ) : (
                <Menu className="h-6 w-6" />
              )}
            </button>
          </div>
        </div>
      </div>

      {/* Mobile Navigation */}
      {renderMobileNav()}
    
      <Dialog open={eligibilityModalOpen} onOpenChange={setEligibilityModalOpen}>
        <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle className="text-2xl font-bold text-center mb-4">Let us find the best programs for you</DialogTitle>
          </DialogHeader>
          <UserForm onSubmit={handleModalFormSubmit} />
          <div className="mt-4 text-center">
            <Link 
              to="/Programs" 
              onClick={() => setEligibilityModalOpen(false)}
              className="text-sm font-medium text-green-600 hover:text-green-800 hover:underline"
            >
              Skip this, go direct to the Programs listing
            </Link>
          </div>
        </DialogContent>
      </Dialog>
    </header>
  );
}
