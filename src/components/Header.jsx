import React, { useState, useEffect } from "react";
import { Link, useLocation } from "react-router-dom";
import { useAuth } from "@/lib/AuthContext";
import { Button } from "@/components/ui/button";
import { Leaf, Menu, X, User } from "lucide-react";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import UserForm from "@/components/UserForm";

export default function Header() {
  const { user, signOut } = useAuth();
  const [isScrolled, setIsScrolled] = useState(false);
  const [isVisible, setIsVisible] = useState(true);
  const [lastScrollY, setLastScrollY] = useState(0);
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const location = useLocation();
  const [eligibilityModalOpen, setEligibilityModalOpen] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      const currentScrollY = window.scrollY;
      
      // Add shadow if scrolled past 10px
      if (currentScrollY > 10) {
        setIsScrolled(true);
      } else {
        setIsScrolled(false);
      }

      // Hide header on scroll down, show on scroll up
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

  // Close mobile menu on route change
  useEffect(() => {
    setMobileMenuOpen(false);
  }, [location]);

  
  const handleProgramsClick = (e) => {
    if (user) return; // Allow normal link behavior for authenticated users
    
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
    { name: "Blog", path: "/Blog" },
    { name: "Community", path: "/Community" },
    { name: "Services", path: "/Services" },
    { name: "About", path: "/About" }
  ];

  const authLinks = [
    { name: "Dashboard", path: "/Dashboard" },
    { name: "My Programs", path: "/My-Programs" },
    { name: "Profile", path: "/Profile" }
  ];

  const renderDesktopNav = () => (
    <nav className="hidden md:flex items-center space-x-8">
      {navLinks.map((link) => {
        const isActive = location.pathname === link.path || (link.name === 'Programs' && location.pathname.toLowerCase() === '/programs');
        const activeClass = isActive ? 'text-green-700 font-semibold' : 'text-gray-700 hover:text-green-700';

        if (link.name === 'Programs' && !user) {
          return (
            <a 
              key={link.name} 
              href={link.path}
              onClick={handleProgramsClick}
              className={`text-sm font-medium transition-colors cursor-pointer ${activeClass}`}
            >
              {link.name}
            </a>
          );
        }
        return (
          <Link 
            key={link.name} 
            to={link.path}
            className={`text-sm font-medium transition-colors ${activeClass}`}
          >
            {link.name}
          </Link>
        );
      })}

      {user && (
        <div className="flex items-center space-x-6 border-l pl-6 border-gray-200">
          {authLinks.map((link) => {
            const isActive = location.pathname === link.path;
            const activeClass = isActive ? 'text-green-700 font-semibold' : 'text-gray-700 hover:text-green-700';
            return (
              <Link 
                key={link.name} 
                to={link.path}
                className={`text-sm font-medium transition-colors ${activeClass}`}
              >
                {link.name}
              </Link>
            );
          })}
          <Button variant="ghost" onClick={signOut} className="text-gray-600 hover:text-red-600">
            Sign Out
          </Button>
        </div>
      )}

      {!user && (
        <div className="flex items-center space-x-4">
          <Link to="/login">
            <Button variant="outline" className="border-green-600 text-green-700 hover:bg-green-50">
              Sign In
            </Button>
          </Link>
          <Link to="/login?view=signup">
            <Button className="bg-green-700 hover:bg-green-800">
              Get Started
            </Button>
          </Link>
        </div>
      )}
    </nav>
  );

  const renderMobileNav = () => (
    <div className={`md:hidden absolute top-16 left-0 w-full bg-white shadow-xl border-t border-gray-100 transition-all duration-300 ease-in-out ${mobileMenuOpen ? 'opacity-100 visible h-auto' : 'opacity-0 invisible h-0 overflow-hidden'}`}>
      <div className="flex flex-col p-4 space-y-4">
        {navLinks.map((link) => {
          const isActive = location.pathname === link.path || (link.name === 'Programs' && location.pathname.toLowerCase() === '/programs');
          const activeClass = isActive ? 'text-green-700 font-semibold' : 'text-gray-800 hover:text-green-700';

          if (link.name === 'Programs' && !user) {
            return (
              <a 
                key={link.name} 
                href={link.path}
                onClick={handleProgramsClick}
                className={`text-base font-medium py-2 border-b border-gray-50 cursor-pointer block ${activeClass}`}
              >
                {link.name}
              </a>
            );
          }
          return (
            <Link 
              key={link.name} 
              to={link.path}
              className={`text-base font-medium py-2 border-b border-gray-50 block ${activeClass}`}
            >
              {link.name}
            </Link>
          );
        })}

        {user ? (
          <>
            <div className="pt-2 pb-1">
              <p className="text-xs font-semibold text-gray-400 uppercase tracking-wider">Account</p>
            </div>
            {authLinks.map((link) => {
              const isActive = location.pathname === link.path;
              const activeClass = isActive ? 'text-green-700 font-semibold' : 'text-gray-800 hover:text-green-700';
              return (
                <Link 
                  key={link.name} 
                  to={link.path}
                  className={`text-base font-medium py-2 border-b border-gray-50 block ${activeClass}`}
                >
                  {link.name}
                </Link>
              );
            })}
            <button 
              onClick={signOut}
              className="text-left text-base font-medium text-red-600 py-2"
            >
              Sign Out
            </button>
          </>
        ) : (
          <div className="flex flex-col space-y-3 pt-4">
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
              <Leaf className="h-8 w-8 text-green-600" />
              <span className="font-bold text-xl text-green-900 tracking-tight">UBI Finder</span>
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
