import React from "react";
import { Link } from "react-router-dom";
import { createPageUrl } from "@/utils";
import { Leaf } from "lucide-react";

export default function Footer() {
  return (
    <footer className="bg-green-50/50 border-t border-green-100">
      <div className="container mx-auto px-4 py-12">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          <div>
            <div className="flex items-center space-x-2 mb-4">
              <Leaf className="w-5 h-5 text-green-700" />
              <span className="font-semibold text-green-900">UBI Finder</span>
            </div>
            <p className="text-sm text-green-800/70">
              Connecting people with Universal Basic Income opportunities worldwide.
            </p>
          </div>
          
          <div>
            <h3 className="font-semibold text-green-900 mb-4">Programs</h3>
            <ul className="space-y-2 text-sm text-green-800/70">
              <li><Link to={createPageUrl("Programs")}>Browse Programs</Link></li>
              <li><Link to={createPageUrl("Submit-Program")}>Submit Program</Link></li>
              <li><Link to="/Services">Enterprise Services</Link></li>
              <li><Link to={createPageUrl("My-Programs")}>Manage Programs</Link></li>
              <li><Link to={createPageUrl("Dashboard")}>My Dashboard</Link></li>
            </ul>
          </div>
          
          <div>
            <h3 className="font-semibold text-green-900 mb-4">Community</h3>
            <ul className="space-y-2 text-sm text-green-800/70">
              <li><Link to={createPageUrl("Blog")}>Blog</Link></li>
              <li><Link to={createPageUrl("Community")}>Community Forum</Link></li>
              <li><Link to={createPageUrl("About")}>About Us</Link></li>
              <li><Link to="/Ecosystem">Ecosystem</Link></li>
              <li><a href="mailto:support@ubifinder.org">Contact Support</a></li>
            </ul>
          </div>
          
          <div>
            <h3 className="font-semibold text-green-900 mb-4">Legal</h3>
            <ul className="space-y-2 text-sm text-green-800/70">
              <li><Link to={createPageUrl("Terms")}>Terms of Service</Link></li>
              <li><Link to={createPageUrl("Privacy")}>Privacy Policy</Link></li>
              <li><Link to={createPageUrl("Cookie-Policy")}>Cookie Policy</Link></li>
              <li><Link to={createPageUrl("Disclaimer")}>Disclaimer</Link></li>
              <li><Link to={createPageUrl("Accessibility")}>Accessibility</Link></li>
            </ul>
          </div>
        </div>
        
        <div className="mt-8 pt-8 border-t border-green-200">
          <div className="flex flex-col md:flex-row justify-between items-center">
            <p className="text-sm text-green-800/70 mb-4 md:mb-0">
              © 2024 UBI Finder. All rights reserved.
            </p>
          </div>
        </div>
      </div>
    </footer>
  );
}

