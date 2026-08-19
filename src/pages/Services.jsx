import React, { useState } from "react";
import { supabase } from "@/lib/supabaseClient";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent } from "@/components/ui/card";
import { 
  Settings, 
  Target, 
  Smartphone, 
  Building2, 
  ShieldCheck, 
  MapPin, 
  Wallet, 
  Link as LinkIcon,
  CheckCircle2,
  Users
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
      title: "Program Design",
      description: "From concept to launch, we help design the economics, tokenomics, and incentive structures of your UBI program."
    },
    {
      icon: <Users className="w-6 h-6 text-green-600" />, // Wait, need to import Users
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
      title: "Geofencing",
      description: "Restrict access based on precise geolocation parameters for hyper-local UBI initiatives."
    },
    {
      icon: <Wallet className="w-6 h-6 text-green-600" />,
      title: "Payout Operations",
      description: "Automated, reliable, and auditable payout scheduling and disbursement management."
    },
    {
      icon: <LinkIcon className="w-6 h-6 text-green-600" />,
      title: "Blockchain Rails",
      description: "Design and implement secure smart contracts on your preferred L1/L2 for transparent fund distribution."
    }
  ];

  return (
    <div className="min-h-screen bg-gray-50 pt-16 pb-24">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        
        {/* Header */}
        <div className="text-center max-w-3xl mx-auto mb-16">
          <h1 className="text-4xl font-extrabold text-gray-900 sm:text-5xl">
            Launch Your Own UBI Program?
          </h1>
          <p className="mt-6 text-xl text-gray-600 leading-relaxed">
            <a href="https://firebelly.xyz" target="_blank" rel="noopener noreferrer" className="text-green-700 font-semibold hover:underline">Firebelly.xyz</a> is a technical consultancy passionate about building a post-capitalistic society—and we're eager to make it a practical reality. From soup to nuts, we provide the infrastructure, technology, and compliance ops you need to build scalable Universal Basic Income and community reward programs.
          </p>
        </div>

        {/* Why Build a UBI Program Section */}
        <div className="mb-20">
          <div className="text-center mb-10">
            <h2 className="text-3xl font-bold text-gray-900">Why Build a UBI or Rewards Program?</h2>
            <p className="mt-4 text-lg text-gray-600 max-w-3xl mx-auto">
              Universal Basic Income isn't just a theoretical concept; it's a powerful mechanism for community empowerment, economic stimulation, and unprecedented member loyalty.
            </p>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <Card className="border-green-100 bg-green-50/50">
              <CardContent className="p-6">
                <h3 className="text-xl font-bold text-green-900 mb-3">Credit Unions & Neobanks</h3>
                <p className="text-gray-700">
                  Drive unparalleled member retention and financial wellness. By distributing regular rewards or basic income dividends, you transform passive account holders into deeply engaged, loyal community members.
                </p>
              </CardContent>
            </Card>
            <Card className="border-green-100 bg-green-50/50">
              <CardContent className="p-6">
                <h3 className="text-xl font-bold text-green-900 mb-3">Blockchain Foundations</h3>
                <p className="text-gray-700">
                  Distribute network ownership fairly and bootstrap powerful network effects. A Sybil-resistant UBI airdrop is the most effective way to decentralize a protocol while creating massive grassroots adoption.
                </p>
              </CardContent>
            </Card>
            <Card className="border-green-100 bg-green-50/50">
              <CardContent className="p-6">
                <h3 className="text-xl font-bold text-green-900 mb-3">Cooperatives & Local Govs</h3>
                <p className="text-gray-700">
                  Circulate wealth locally and establish a dependable financial floor. Keep capital within your ecosystem to strengthen local businesses, empower residents, and build a resilient cooperative economy.
                </p>
              </CardContent>
            </Card>
          </div>
        </div>

        {/* Case Studies Section */}
        <div className="mb-20">
          <div className="text-center mb-10">
            <h2 className="text-3xl font-bold text-gray-900">Our Track Record</h2>
            <p className="mt-4 text-lg text-gray-600 max-w-3xl mx-auto">
              We don't just consult; we build. Here is how we're already shaping the future of decentralized income.
            </p>
          </div>
          <div className="space-y-6">
            <Card className="border-gray-200 overflow-hidden">
              <div className="md:flex">
                <div className="md:w-1/3 bg-green-700 p-6 flex flex-col justify-center items-center text-center text-white">
                  <h3 className="text-2xl font-bold mb-2">GoodDollar</h3>
                  <div className="text-green-100 text-sm uppercase tracking-wide font-semibold">Protocol Architecture</div>
                </div>
                <div className="md:w-2/3 p-6 flex flex-col justify-center">
                  <p className="text-gray-700 text-lg">
                    We've helped build GoodDollar, one of the world's largest and most accessible blockchain-based UBI protocols, successfully distributing digital basic income to hundreds of thousands of users worldwide.
                  </p>
                </div>
              </div>
            </Card>
            
            <Card className="border-gray-200 overflow-hidden">
              <div className="md:flex">
                <div className="md:w-1/3 bg-green-600 p-6 flex flex-col justify-center items-center text-center text-white">
                  <h3 className="text-2xl font-bold mb-2">UBI Finder</h3>
                  <div className="text-green-100 text-sm uppercase tracking-wide font-semibold">Public Good Platform</div>
                </div>
                <div className="md:w-2/3 p-6 flex flex-col justify-center">
                  <p className="text-gray-700 text-lg">
                    We built and maintain this very site as a free public service to the community. UBI Finder helps individuals discover, verify, and access life-changing financial support programs across the globe.
                  </p>
                </div>
              </div>
            </Card>

            <Card className="border-gray-200 overflow-hidden">
              <div className="md:flex">
                <div className="md:w-1/3 bg-green-500 p-6 flex flex-col justify-center items-center text-center text-white">
                  <h3 className="text-2xl font-bold mb-2">FundLoop.org</h3>
                  <div className="text-green-100 text-sm uppercase tracking-wide font-semibold">Active Development</div>
                </div>
                <div className="md:w-2/3 p-6 flex flex-col justify-center">
                  <p className="text-gray-700 text-lg">
                    We are currently in the process of building FundLoop.org, an upcoming innovative platform designed to radically streamline and democratize fund distribution and cooperative economics.
                  </p>
                </div>
              </div>
            </Card>
          </div>
        </div>

        {/* Services Grid Header */}
        <div className="text-center mb-10">
          <h2 className="text-3xl font-bold text-gray-900">How We Can Help You</h2>
        </div>


        {/* Services Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-20">
          {services.map((service, index) => (
            <Card key={index} className="border-none shadow-md hover:shadow-lg transition-shadow">
              <CardContent className="p-6">
                <div className="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center mb-4">
                  {service.icon}
                </div>
                <h3 className="text-lg font-bold text-gray-900 mb-2">{service.title}</h3>
                <p className="text-gray-600 text-sm leading-relaxed">
                  {service.description}
                </p>
              </CardContent>
            </Card>
          ))}
        </div>

        {/* Intake Form */}
        <div className="max-w-2xl mx-auto bg-white rounded-2xl shadow-xl overflow-hidden">
          <div className="bg-green-700 py-8 px-8 text-center">
            <h2 className="text-2xl font-bold text-white mb-2">Ready to explore?</h2>
            <p className="text-green-100">Drop us a line and let's discuss how we can help your program succeed.</p>
          </div>
          <div className="p-8">
            {success ? (
              <div className="text-center py-8">
                <CheckCircle2
  className="w-16 h-16 text-green-500 mx-auto mb-4" />
                <h3 className="text-2xl font-bold text-gray-900 mb-2">Message Received!</h3>
                <p className="text-gray-600">Thank you for reaching out. Our team will get back to you within 24 hours.</p>
                <Button 
                  onClick={() => setSuccess(false)}
                  className="mt-6 bg-green-700 hover:bg-green-800"
                >
                  Send Another Message
                </Button>
              </div>
            ) : (
              <form onSubmit={handleSubmit} className="space-y-6">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div>
                    <label htmlFor="name" className="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
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
                    <label htmlFor="email" className="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
                    <Input 
                      id="email"
                      name="email"
                      type="email"
                      required
                      value={formData.email}
                      onChange={handleChange}
                      placeholder="jane@example.com"
                    />
                  </div>
                </div>
                
                <div>
                  <label htmlFor="organization" className="block text-sm font-medium text-gray-700 mb-1">Organization (Optional)</label>
                  <Input 
                    id="organization"
                    name="organization"
                    value={formData.organization}
                    onChange={handleChange}
                    placeholder="Global UBI Foundation"
                  />
                </div>

                <div>
                  <label htmlFor="message" className="block text-sm font-medium text-gray-700 mb-1">How can we help?</label>
                  <textarea
                    id="message"
                    name="message"
                    required
                    rows={4}
                    value={formData.message}
                    onChange={handleChange}
                    className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                    placeholder="Tell us about your program's goals and what services you're interested in..."
                  />
                </div>

                {error && <p className="text-red-600 text-sm">{error}</p>}

                <Button 
                  type="submit" 
                  disabled={loading}
                  className="w-full bg-green-700 hover:bg-green-800 py-6 text-lg"
                >
                  {loading ? "Sending..." : "Submit Inquiry"}
                </Button>
              </form>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
