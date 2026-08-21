import React, { useEffect } from "react";
import { Button } from "@/components/ui/button";
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@/components/ui/accordion";
import { Card, CardContent } from "@/components/ui/card";
import { 
  Leaf, 
  Mail, 
  MessageSquare, 
  ExternalLink, 
  Sparkles,
  Globe2,
  ShieldCheck,
  Zap,
  Users,
  CheckCircle2,
  Lock,
  ArrowRight,
  TrendingUp,
  Heart,
  Landmark,
  Coins,
  Cpu
} from "lucide-react";
import { Link } from "react-router-dom";
import PageHeader from "@/components/ui/page-header";
import { Helmet } from "react-helmet-async";

export default function About() {
  useEffect(() => {
    window.scrollTo(0, 0);
  }, []);

  const corePillars = [
    {
      icon: <Globe2 className="w-6 h-6 text-emerald-600" />,
      title: "Universality",
      subtitle: "For Everyone in the Region",
      description: "Paid unconditionally to all qualifying members of a geographical community, eliminating exclusionary red tape."
    },
    {
      icon: <Lock className="w-6 h-6 text-emerald-600" />,
      title: "Unconditionality",
      subtitle: "No Means-Testing Strings",
      description: "Recipients receive cash directly without behavioral requirements, work mandates, or stigmatizing questionnaires."
    },
    {
      icon: <Zap className="w-6 h-6 text-emerald-600" />,
      title: "Regularity",
      subtitle: "Predictable Cash Floor",
      description: "Disbursements occur on scheduled, dependable cycles (daily, bi-weekly, or monthly)—providing a reliable economic cushion."
    },
    {
      icon: <Users className="w-6 h-6 text-emerald-600" />,
      title: "Individual Basis",
      subtitle: "Personal Agency & Dignity",
      description: "Payments are delivered to individuals rather than head-of-household structures, promoting financial autonomy."
    }
  ];

  const howItWorks = [
    {
      step: "01",
      title: "Scour & Verify Global Pilots",
      desc: "Our automated crawlers and research team aggregate government pilots, philanthropic cash grants, and Web3 daily claim protocols."
    },
    {
      step: "02",
      title: "Privacy-Preserving Matching",
      desc: "We compare your location, household dynamics, and delivery preferences without ever selling your data or imposing means tests."
    },
    {
      step: "03",
      title: "1-Click Direct Application",
      desc: "Get instant access to official intake portals, disbursement schedules, application deadlines, and community discussion hubs."
    }
  ];

  return (
    <>
      <Helmet>
        <title>About UBI Finder — Mission, Principles & Global Impact</title>
        <meta name="description" content="Discover how UBI Finder is cataloging and democratizing access to Universal Basic Income pilots, municipal cash transfers, and Web3 protocols worldwide." />
      </Helmet>

      <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-12">
        <div className="max-w-5xl mx-auto space-y-16">
          
          {/* Header */}
          <PageHeader
            icon={Leaf}
            badgeText="Our Mission & Public Good"
            title="Democratizing Access to Basic Income"
            subtitle="UBI Finder is a public-good directory connecting people with verified Universal Basic Income experiments, municipal cash floors, and decentralized protocols across the globe."
          />

          {/* Key Metrics Strip */}
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            <Card className="border-green-100 bg-white/90 shadow-sm text-center p-5 hover:shadow-md transition-all">
              <div className="text-3xl md:text-4xl font-extrabold text-green-900 mb-1">100%</div>
              <div className="text-xs font-semibold text-gray-500 uppercase tracking-wider">Free Public Good</div>
            </Card>
            <Card className="border-green-100 bg-white/90 shadow-sm text-center p-5 hover:shadow-md transition-all">
              <div className="text-3xl md:text-4xl font-extrabold text-green-900 mb-1">180+</div>
              <div className="text-xs font-semibold text-gray-500 uppercase tracking-wider">Countries Covered</div>
            </Card>
            <Card className="border-green-100 bg-white/90 shadow-sm text-center p-5 hover:shadow-md transition-all">
              <div className="text-3xl md:text-4xl font-extrabold text-green-900 mb-1">Multi-Rail</div>
              <div className="text-xs font-semibold text-gray-500 uppercase tracking-wider">Fiat, Cards & Web3</div>
            </Card>
            <Card className="border-green-100 bg-white/90 shadow-sm text-center p-5 hover:shadow-md transition-all">
              <div className="text-3xl md:text-4xl font-extrabold text-green-900 mb-1">0</div>
              <div className="text-xs font-semibold text-gray-500 uppercase tracking-wider">Middlemen Fees</div>
            </Card>
          </div>

          {/* Core UBI Principles Grid */}
          <div className="space-y-6">
            <div className="text-center max-w-2xl mx-auto">
              <div className="inline-flex items-center gap-1.5 px-3 py-1 bg-green-100/80 rounded-full text-xs font-bold text-green-800 mb-2">
                <Sparkles className="w-3.5 h-3.5 text-green-700" />
                The 4 Cornerstones
              </div>
              <h2 className="text-2xl md:text-3xl font-bold text-gray-900">What Makes True Universal Basic Income?</h2>
              <p className="text-sm text-gray-600 mt-2">
                Unlike complex conditional welfare, genuine basic income is rooted in trust, predictability, and personal freedom.
              </p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {corePillars.map((pillar, idx) => (
                <Card key={idx} className="border-gray-200/80 hover:border-green-300 shadow-sm hover:shadow-lg transition-all transform hover:-translate-y-1 bg-white/95">
                  <CardContent className="p-6 space-y-3">
                    <div className="w-12 h-12 rounded-xl bg-green-50 border border-green-200 flex items-center justify-center">
                      {pillar.icon}
                    </div>
                    <div>
                      <h3 className="text-lg font-bold text-green-950">{pillar.title}</h3>
                      <p className="text-xs font-semibold text-green-700 uppercase tracking-wide">{pillar.subtitle}</p>
                    </div>
                    <p className="text-sm text-gray-600 leading-relaxed">
                      {pillar.description}
                    </p>
                  </CardContent>
                </Card>
              ))}
            </div>
          </div>

          {/* How UBI Finder Works */}
          <div className="bg-gradient-to-br from-green-900 via-green-800 to-emerald-950 rounded-3xl p-8 md:p-12 text-white shadow-xl relative overflow-hidden">
            <div className="absolute top-0 right-0 -mt-8 -mr-8 w-64 h-64 bg-green-600/10 rounded-full blur-3xl" />
            <div className="relative z-10 space-y-8">
              <div className="max-w-2xl">
                <span className="text-xs font-bold uppercase tracking-wider text-green-300">How It Works</span>
                <h2 className="text-3xl font-extrabold text-white mt-1">Connecting You with Direct Cash Support</h2>
                <p className="text-green-100 text-sm mt-2 leading-relaxed">
                  We demystify the fragmented landscape of cash pilots, municipal dividend programs, and global blockchain airdrops.
                </p>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                {howItWorks.map((item, idx) => (
                  <div key={idx} className="bg-white/10 backdrop-blur-md rounded-2xl p-6 border border-white/10 space-y-3">
                    <span className="text-2xl font-black text-green-300 opacity-80">{item.step}</span>
                    <h3 className="text-base font-bold text-white">{item.title}</h3>
                    <p className="text-xs text-green-100/80 leading-relaxed">{item.desc}</p>
                  </div>
                ))}
              </div>

              <div className="pt-4 flex flex-col sm:flex-row items-center gap-4">
                <Link to="/Programs">
                  <Button size="lg" className="bg-white text-green-900 hover:bg-green-50 font-bold px-6 shadow-md">
                    Explore Verified Programs &rarr;
                  </Button>
                </Link>
                <Link to="/Services">
                  <Button variant="outline" size="lg" className="border-green-300 text-green-100 hover:bg-white/10">
                    Launching a Pilot? Talk to Firebelly
                  </Button>
                </Link>
              </div>
            </div>
          </div>

          {/* Why Now? The Modern Context */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            <Card className="border-gray-200 bg-white/95 shadow-sm p-6 space-y-3">
              <Cpu className="w-8 h-8 text-green-700" />
              <h3 className="text-base font-bold text-gray-900">AI & Automation</h3>
              <p className="text-xs text-gray-600 leading-relaxed">
                As artificial intelligence reorganizes labor, unconditional dividends ensure technological gains broadly circulate throughout society.
              </p>
            </Card>

            <Card className="border-gray-200 bg-white/95 shadow-sm p-6 space-y-3">
              <Heart className="w-8 h-8 text-green-700" />
              <h3 className="text-base font-bold text-gray-900">Health & Family Outcomes</h3>
              <p className="text-xs text-gray-600 leading-relaxed">
                Empirical trials from Stockton to Kenya demonstrate reduced infant mortality, improved mental wellness, and higher educational completion.
              </p>
            </Card>

            <Card className="border-gray-200 bg-white/95 shadow-sm p-6 space-y-3">
              <Coins className="w-8 h-8 text-green-700" />
              <h3 className="text-base font-bold text-gray-900">Decentralized Payout Rails</h3>
              <p className="text-xs text-gray-600 leading-relaxed">
                Blockchain rails and smart contracts enable direct, zero-fee, cross-border digital income directly to smartphones without legacy banking delays.
              </p>
            </Card>
          </div>

          {/* FAQs Accordion */}
          <div className="space-y-6">
            <div className="text-center max-w-2xl mx-auto">
              <h2 className="text-2xl md:text-3xl font-bold text-gray-900">Frequently Asked Questions</h2>
              <p className="text-sm text-gray-600 mt-1">Everything you need to know about UBI Finder and basic income pilots.</p>
            </div>

            <Card className="shadow-md border-gray-200 bg-white/95">
              <CardContent className="p-6">
                <Accordion type="single" collapsible className="w-full space-y-2">
                  <AccordionItem value="item-1">
                    <AccordionTrigger className="text-left font-semibold text-gray-900 hover:text-green-700">
                      What is the difference between Universal Basic Income and traditional welfare?
                    </AccordionTrigger>
                    <AccordionContent className="text-gray-600 text-sm leading-relaxed">
                      Unlike traditional welfare programs with means testing, work reporting requirements, and usage restrictions, Universal Basic Income is provided unconditionally. Recipients have complete autonomy over how funds are spent, eliminating stigma, bureaucratic delays, and administrative overhead.
                    </AccordionContent>
                  </AccordionItem>

                  <AccordionItem value="item-2">
                    <AccordionTrigger className="text-left font-semibold text-gray-900 hover:text-green-700">
                      How are the programs on this platform funded?
                    </AccordionTrigger>
                    <AccordionContent className="text-gray-600 text-sm leading-relaxed">
                      Basic income pilots originate from varied funding sources:
                      <ul className="list-disc pl-5 mt-2 space-y-1 text-xs">
                        <li><strong>Municipal & State Budgets:</strong> General tax revenue or public sovereign funds (e.g. Alaska Permanent Fund).</li>
                        <li><strong>Philanthropic Grants:</strong> Non-profits, foundations, and academic lab grants (e.g. GiveDirectly, Stanford Basic Income Lab).</li>
                        <li><strong>Web3 Protocols:</strong> Smart contract token reserves and protocol treasury yield (e.g. GoodDollar, Circles).</li>
                        <li><strong>Community Crowdfunding:</strong> Citizen-backed recurring micro-donations (e.g. Mein Grundeinkommen).</li>
                      </ul>
                    </AccordionContent>
                  </AccordionItem>

                  <AccordionItem value="item-3">
                    <AccordionTrigger className="text-left font-semibold text-gray-900 hover:text-green-700">
                      Does UBI Finder charge any fees to applicants?
                    </AccordionTrigger>
                    <AccordionContent className="text-gray-600 text-sm leading-relaxed">
                      No. UBI Finder is 100% free and open public good software. We never charge application fees, premium subscription tiers, or referral cuts. Our directory is maintained as a community service by <a href="https://firebelly.xyz" target="_blank" rel="noopener noreferrer" className="text-green-700 font-semibold hover:underline">Firebelly.xyz</a>.
                    </AccordionContent>
                  </AccordionItem>

                  <AccordionItem value="item-4">
                    <AccordionTrigger className="text-left font-semibold text-gray-900 hover:text-green-700">
                      How are programs reviewed and verified?
                    </AccordionTrigger>
                    <AccordionContent className="text-gray-600 text-sm leading-relaxed">
                      Every submission undergoes rigorous verification: confirming the entity's non-profit or government registration, checking for transparent fund reserves, confirming historical disbursements, and validating that application portals are secure and official.
                    </AccordionContent>
                  </AccordionItem>

                  <AccordionItem value="item-5">
                    <AccordionTrigger className="text-left font-semibold text-gray-900 hover:text-green-700">
                      Can I participate in multiple basic income programs?
                    </AccordionTrigger>
                    <AccordionContent className="text-gray-600 text-sm leading-relaxed">
                      In many cases, yes! Web3 daily claim protocols (like GoodDollar) can be claimed simultaneously alongside municipal or localized cash initiatives, unless a specific government experiment explicitly requests single-study participation.
                    </AccordionContent>
                  </AccordionItem>
                </Accordion>
              </CardContent>
            </Card>
          </div>

          {/* Contact & Community Card */}
          <Card className="border-green-200 bg-green-50/50 shadow-md">
            <CardContent className="p-8">
              <div className="grid md:grid-cols-2 gap-8 items-center">
                <div className="space-y-3">
                  <span className="text-xs font-bold uppercase tracking-wider text-green-800">Get Involved</span>
                  <h3 className="text-2xl font-extrabold text-green-950">Join the Basic Income Movement</h3>
                  <p className="text-sm text-gray-700 leading-relaxed">
                    Have questions, suggestions, or want to connect with other recipients and researchers? Join our community discussions or submit a missing program.
                  </p>
                  <div className="flex flex-wrap gap-3 pt-2">
                    <Link to="/Community">
                      <Button className="bg-green-700 hover:bg-green-800 text-white font-semibold text-xs shadow-sm flex items-center gap-1.5">
                        <MessageSquare className="w-3.5 h-3.5" />
                        Community Discussions
                      </Button>
                    </Link>
                    <Link to="/Submit-Program">
                      <Button variant="outline" className="border-green-700 text-green-800 hover:bg-green-100 text-xs font-semibold">
                        Submit a Program &rarr;
                      </Button>
                    </Link>
                  </div>
                </div>

                <div className="p-5 bg-white rounded-2xl border border-green-100 shadow-sm space-y-3">
                  <div className="flex items-center gap-3">
                    <div className="p-2.5 bg-green-100 rounded-xl text-green-800">
                      <Mail className="w-5 h-5" />
                    </div>
                    <div>
                      <h4 className="font-bold text-sm text-gray-900">Direct Inquiries & Support</h4>
                      <a href="mailto:info@firebelly.xyz" className="text-xs text-green-700 hover:underline font-semibold">
                        info@firebelly.xyz
                      </a>
                    </div>
                  </div>
                  <p className="text-xs text-gray-500 leading-relaxed">
                    Maintained with care by <a href="https://firebelly.xyz" target="_blank" rel="noopener noreferrer" className="text-green-800 font-semibold hover:underline">Firebelly.xyz</a> — engineering the infrastructure for post-capitalist abundance.
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>

        </div>
      </div>
    </>
  );
}
