import React, { useState } from "react";
import { supabase } from "@/lib/supabaseClient";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent } from "@/components/ui/card";
import { 
  Target, 
  Smartphone, 
  Building2, 
  ShieldCheck, 
  MapPin, 
  Wallet, 
  Link as LinkIcon,
  CheckCircle2,
  Users,
  Calendar,
  Sparkles,
  ArrowRight,
  ExternalLink
} from "lucide-react";

export default function ServicesPage() {
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    organization: "",
    message: ""
  });
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState(false);
  const [error, setError] = useState("");

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError("");
    
    const { error: submitError } = await supabase
      .from('services_intake')
      .insert([formData]);
      
    setLoading(false);
    
    if (submitError) {
      setError(submitError.message);
    } else {
      setSuccess(true);
      setFormData({ name: "", email: "", organization: "", message: "" });
    }
  };

  const services = [
    {
      icon: <Target className="w-6 h-6 text-green-600" />,
      title: "Program & Incentive Design",
      description: "From concept to launch, we help design the economics, tokenomics, and incentive structures of your UBI program."
    },
    {
      icon: <Users className="w-6 h-6 text-green-600" />,
      title: "Target Audience Vetting",
      description: "Define and identify your target demographic to ensure funds reach those who need it most."
    },
    {
      icon: <Smartphone className="w-6 h-6 text-green-600" />,
      title: "Sleek Web App Development",
      description: "Custom built, high-converting platforms for user onboarding, dashboards, and application flows."
    },
    {
      icon: <Building2 className="w-6 h-6 text-green-600" />,
      title: "Bank Rails Setup",
      description: "Navigate the complex regulatory landscape and set up compliant fiat off-ramps and bank accounts."
    },
    {
      icon: <ShieldCheck className="w-6 h-6 text-green-600" />,
      title: "KYC & OFAC Checks",
      description: "Integrated identity verification, Sybil resistance, and continuous OFAC sanction list screening."
    },
    {
      icon: <MapPin className="w-6 h-6 text-green-600" />,
      title: "Geofencing & Municipal Limits",
      description: "Restrict access based on precise geolocation parameters for hyper-local UBI initiatives."
    },
    {
      icon: <Wallet className="w-6 h-6 text-green-600" />,
      title: "Payout Operations",
      description: "Automated, reliable, and auditable payout scheduling and disbursement management."
    },
    {
      icon: <LinkIcon className="w-6 h-6 text-green-600" />,
      title: "Blockchain Rails & Smart Contracts",
      description: "Design and implement secure smart contracts on your preferred L1/L2 for transparent fund distribution."
    }
  ];

  return (
    <div className="min-h-screen bg-gray-50 pt-16 pb-24">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        {/* Hero Section */}
        <div className="text-center max-w-3xl mx-auto mb-16 space-y-6">
          <div className="inline-flex items-center gap-2 px-3 py-1 bg-green-100 rounded-full text-xs font-semibold text-green-800">
            <Sparkles className="w-3.5 h-3.5" />
            B2B & Municipal Infrastructure
          </div>
          <h1 className="text-4xl font-extrabold text-gray-900 sm:text-5xl leading-tight">
            Launch & Scale Your UBI Program
          </h1>
          <p className="text-lg text-gray-600 leading-relaxed">
            <a href="https://firebelly.xyz" target="_blank" rel="noopener noreferrer" className="text-green-700 font-semibold hover:underline">Firebelly.xyz</a> provides the end-to-end technical infrastructure, compliance ops, and smart contracts to make Universal Basic Income and community reward programs a practical reality.
          </p>

          {/* 7a: "Book a call" CTA in Hero */}
          <div className="flex flex-col sm:flex-row items-center justify-center gap-4 pt-2">
            <a 
              href="https://calendly.com/meet-noak/" 
              target="_blank" 
              rel="noopener noreferrer"
              className="w-full sm:w-auto"
            >
              <Button size="lg" className="w-full sm:w-auto bg-green-700 hover:bg-green-800 text-white font-semibold py-6 px-8 shadow-lg flex items-center justify-center gap-2 cursor-pointer">
                <Calendar className="w-5 h-5" />
                Book a 30-Min Strategy Call
              </Button>
            </a>
            <Button 
              variant="outline" 
              size="lg" 
              onClick={() => {
                document.getElementById('intake-form')?.scrollIntoView({ behavior: 'smooth' });
              }}
              className="w-full sm:w-auto border-gray-300 hover:bg-gray-100 py-6 px-6 cursor-pointer"
            >
              Send Inquiry Form &rarr;
            </Button>
          </div>
        </div>

        {/* Why Build a UBI Program Section */}
        <div className="mb-20">
          <div className="text-center mb-10">
            <h2 className="text-3xl font-bold text-gray-900">Why Launch a Basic Income Program?</h2>
            <p className="mt-3 text-base text-gray-600 max-w-3xl mx-auto">
              Unconditional cash and digital reward transfers drive unprecedented member retention, regional economic velocity, and grassroots engagement.
            </p>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <Card className="border-green-100 bg-white shadow-sm hover:shadow-md transition-all">
              <CardContent className="p-6">
                <h3 className="text-xl font-bold text-green-950 mb-2">Credit Unions & Neobanks</h3>
                <p className="text-gray-600 text-sm leading-relaxed">
                  Drive member retention and financial wellness. By distributing regular rewards or basic income dividends, you transform passive account holders into deeply engaged, loyal community members.
                </p>
              </CardContent>
            </Card>
            <Card className="border-green-100 bg-white shadow-sm hover:shadow-md transition-all">
              <CardContent className="p-6">
                <h3 className="text-xl font-bold text-green-950 mb-2">Blockchain Foundations</h3>
                <p className="text-gray-600 text-sm leading-relaxed">
                  Distribute network ownership fairly and bootstrap network effects. A Sybil-resistant UBI protocol creates organic token velocity and massive grassroots adoption across developing regions.
                </p>
              </CardContent>
            </Card>
            <Card className="border-green-100 bg-white shadow-sm hover:shadow-md transition-all">
              <CardContent className="p-6">
                <h3 className="text-xl font-bold text-green-950 mb-2">Cooperatives & Municipalities</h3>
                <p className="text-gray-600 text-sm leading-relaxed">
                  Circulate wealth locally and establish a dependable financial floor. Keep capital within your ecosystem to strengthen local merchants, empower residents, and build a resilient economy.
                </p>
              </CardContent>
            </Card>
          </div>
        </div>

        {/* 7c: Deep Case Studies Section */}
        <div className="mb-20">
          <div className="text-center mb-10">
            <h2 className="text-3xl font-bold text-gray-900">Our Track Record & Case Studies</h2>
            <p className="mt-3 text-base text-gray-600 max-w-3xl mx-auto">
              Real-world systems delivering reliable payouts and economic empowerment.
            </p>
          </div>
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
            
            {/* Case Study 1: GoodDollar */}
            <Card className="border border-gray-200/90 shadow-md bg-white flex flex-col justify-between overflow-hidden">
              <div className="bg-green-800 p-6 text-white">
                <span className="text-[11px] font-bold uppercase tracking-wider text-green-200">Protocol Engineering</span>
                <h3 className="text-2xl font-extrabold mt-1">GoodDollar</h3>
                <p className="text-xs text-green-100 mt-1">Global Decentralized Basic Income Protocol</p>
              </div>
              <CardContent className="p-6 space-y-4 flex-1 flex flex-col justify-between">
                <div className="space-y-3 text-xs text-gray-600">
                  <div>
                    <strong className="text-gray-900 block text-xs mb-0.5">The Challenge:</strong>
                    Scalable daily distribution of digital income to hundreds of thousands of recipients across 180+ countries with strict Sybil resistance.
                  </div>
                  <div>
                    <strong className="text-gray-900 block text-xs mb-0.5">What We Built:</strong>
                    Smart contract disbursement pipelines, frictionless claim UI/UX, and zero-knowledge identity integration.
                  </div>
                </div>
                <div className="pt-3 border-t border-gray-100 flex items-center justify-between text-xs font-semibold text-green-800">
                  <span>500k+ Active Recipients</span>
                  <span>180+ Countries</span>
                </div>
              </CardContent>
            </Card>
            
            {/* Case Study 2: UBI Finder */}
            <Card className="border border-gray-200/90 shadow-md bg-white flex flex-col justify-between overflow-hidden">
              <div className="bg-green-700 p-6 text-white">
                <span className="text-[11px] font-bold uppercase tracking-wider text-green-200">Public Good Platform</span>
                <h3 className="text-2xl font-extrabold mt-1">UBI Finder</h3>
                <p className="text-xs text-green-100 mt-1">Global Directory & Eligibility Engine</p>
              </div>
              <CardContent className="p-6 space-y-4 flex-1 flex flex-col justify-between">
                <div className="space-y-3 text-xs text-gray-600">
                  <div>
                    <strong className="text-gray-900 block text-xs mb-0.5">The Challenge:</strong>
                    Income pilots are scattered across municipal sites and foundations, making it nearly impossible for eligible applicants to find them.
                  </div>
                  <div>
                    <strong className="text-gray-900 block text-xs mb-0.5">What We Built:</strong>
                    Algorithmic eligibility matching, multi-currency conversions, and live community discourse hubs.
                  </div>
                </div>
                <div className="pt-3 border-t border-gray-100 flex items-center justify-between text-xs font-semibold text-green-800">
                  <span>Verified Pilot Database</span>
                  <span>Instant Match Engine</span>
                </div>
              </CardContent>
            </Card>

            {/* Case Study 3: FundLoop */}
            <Card className="border border-gray-200/90 shadow-md bg-white flex flex-col justify-between overflow-hidden">
              <div className="bg-emerald-700 p-6 text-white">
                <span className="text-[11px] font-bold uppercase tracking-wider text-emerald-200">Incubator & Treasury</span>
                <h3 className="text-2xl font-extrabold mt-1">FundLoop.org</h3>
                <p className="text-xs text-emerald-100 mt-1">Democratized Fund Distribution</p>
              </div>
              <CardContent className="p-6 space-y-4 flex-1 flex flex-col justify-between">
                <div className="space-y-3 text-xs text-gray-600">
                  <div>
                    <strong className="text-gray-900 block text-xs mb-0.5">The Challenge:</strong>
                    Empowering early-stage regenerative ventures with transparent milestone payouts and community governance treasuries.
                  </div>
                  <div>
                    <strong className="text-gray-900 block text-xs mb-0.5">What We Built:</strong>
                    Milestone-gated smart escrow, multi-signature treasury controllers, and transparent disbursement feeds.
                  </div>
                </div>
                <div className="pt-3 border-t border-gray-100 flex items-center justify-between text-xs font-semibold text-green-800">
                  <span>Cooperative Escrow</span>
                  <span>Regenerative Grants</span>
                </div>
              </CardContent>
            </Card>

          </div>

          {/* External Portfolio Link */}
          <div className="mt-8 text-center">
            <a
              href="https://firebelly.xyz/portfolio"
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center gap-1.5 text-sm font-semibold text-green-700 hover:text-green-800 hover:underline transition-colors cursor-pointer"
            >
              See our full list of projects
              <ExternalLink className="w-4 h-4 ml-0.5" />
            </a>
          </div>
        </div>

        {/* Services Grid */}
        <div className="mb-20">
          <div className="text-center mb-10">
            <h2 className="text-3xl font-bold text-gray-900">End-to-End Capabilities</h2>
            <p className="mt-2 text-sm text-gray-600">Full lifecycle engineering for basic income & community dividend programs.</p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            {services.map((service, index) => (
              <Card key={index} className="border-none shadow-sm hover:shadow-md transition-shadow bg-white">
                <CardContent className="p-6">
                  <div className="w-12 h-12 bg-green-100 rounded-xl flex items-center justify-center mb-4">
                    {service.icon}
                  </div>
                  <h3 className="text-base font-bold text-gray-900 mb-1.5">{service.title}</h3>
                  <p className="text-gray-600 text-xs leading-relaxed">
                    {service.description}
                  </p>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>

        {/* Intake Form */}
        <div id="intake-form" className="max-w-2xl mx-auto bg-white rounded-2xl shadow-xl overflow-hidden border border-green-100">
          <div className="bg-green-800 py-8 px-8 text-center text-white">
            <h2 className="text-2xl font-bold mb-1">Ready to Build Your Program?</h2>
            <p className="text-green-100 text-xs">Drop us a line and let's discuss technical architecture, timelines, and deployment.</p>
          </div>
          <div className="p-8">
            {success ? (
              <div className="text-center py-8">
                <CheckCircle2 className="w-16 h-16 text-green-600 mx-auto mb-4" />
                <h3 className="text-2xl font-bold text-gray-900 mb-2">Inquiry Received!</h3>
                <p className="text-gray-600 text-sm max-w-md mx-auto">
                  Thank you for reaching out. The Firebelly technical team will review your requirements and respond promptly.
                </p>
                <div className="mt-6 flex items-center justify-center">
                  <a 
                    href="https://calendly.com/meet-noak/"
                    target="_blank"
                    rel="noopener noreferrer"
                    className="inline-flex items-center gap-2 px-6 py-3 rounded-lg text-sm font-semibold bg-green-700 hover:bg-green-800 text-white shadow-md transition-all cursor-pointer"
                  >
                    <Calendar className="w-4 h-4" />
                    Book a meeting with us
                    <ExternalLink className="w-3.5 h-3.5 opacity-80 ml-0.5" />
                  </a>
                </div>
              </div>
            ) : (
              <form onSubmit={handleSubmit} className="space-y-5">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
                  <div>
                    <label htmlFor="name" className="block text-xs font-semibold text-gray-700 mb-1">Full Name</label>
                    <Input 
                      id="name"
                      name="name"
                      required
                      value={formData.name}
                      onChange={handleChange}
                      placeholder="Jane Doe"
                    />
                  </div>
                  <div>
                    <label htmlFor="email" className="block text-xs font-semibold text-gray-700 mb-1">Work Email</label>
                    <Input 
                      id="email"
                      name="email"
                      type="email"
                      required
                      value={formData.email}
                      onChange={handleChange}
                      placeholder="jane@organization.org"
                    />
                  </div>
                </div>
                
                <div>
                  <label htmlFor="organization" className="block text-xs font-semibold text-gray-700 mb-1">Organization / Foundation (Optional)</label>
                  <Input 
                    id="organization"
                    name="organization"
                    value={formData.organization}
                    onChange={handleChange}
                    placeholder="Global Basic Income Lab"
                  />
                </div>

                <div>
                  <label htmlFor="message" className="block text-xs font-semibold text-gray-700 mb-1">How can we help your initiative?</label>
                  <textarea
                    id="message"
                    name="message"
                    required
                    rows={4}
                    value={formData.message}
                    onChange={handleChange}
                    className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
                    placeholder="Tell us about your program size, payout currency, target region, and technical needs..."
                  />
                </div>

                {error && <p className="text-red-600 text-xs">{error}</p>}

                <Button 
                  type="submit" 
                  disabled={loading}
                  className="w-full bg-green-700 hover:bg-green-800 py-6 text-base font-semibold shadow-md"
                >
                  {loading ? "Sending..." : "Submit Inquiry & Request Strategy Session"}
                </Button>
              </form>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
