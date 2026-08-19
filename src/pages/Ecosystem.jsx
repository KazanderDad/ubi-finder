import React from 'react';
import { Card, CardContent } from '@/components/ui/card';
import { ExternalLink } from 'lucide-react';

export default function EcosystemPage() {
  const projects = [
    { id: "01", name: "ChainCrew", url: "https://chaincrew.xyz/", description: "Team up in Crews to manage memberships, events, and community treasuries." },
    { id: "02", name: "ClearPass", url: "https://clearpass.app/", description: "KYC verification with NFC-enabled passports and driver's licenses." },
    { id: "03", name: "Cubid", url: "https://cubid.me/", description: "Privacy-preserving identity infrastructure with proofs and stamps." },
    { id: "04", name: "EquityFlow", url: "https://equityflow.xyz/", description: "Tools for equity and commitment-sharing among founders and teams." },
    { id: "05", name: "Firebelly", url: "https://firebelly.xyz/", description: "Innovation studio supporting regenerative and Web3 ventures." },
    { id: "06", name: "FundLoop", url: "https://fundloop.org/", description: "Collaborative incubator and funding network for early-stage projects." },
    { id: "07", name: "FreeForm", url: "https://usefreeform.com/", description: "A next-gen form builder with voting, branching, and identity options." },
    { id: "08", name: "GreenPill Canada", url: "https://greenpill.ca/", description: "Building local regenerative economies across Canada." },
    { id: "09", name: "GreenPill Toronto", url: "https://greenpill.to/", description: "Toronto's node of the global GreenPill network." },
    { id: "10", name: "I Am Human", url: "https://www.i-am-human.app/", description: "Developer infrastructure for sybil resistance." },
    { id: "11", name: "Procent Foundation", url: "https://procentfoundation.com/", description: "A nonprofit supporting public goods and open innovation." },
    { id: "12", name: "Safe2Meet", url: "https://safe2meet.me/", description: "Safer in-person meetups for real estate, classifieds, and dating." },
    { id: "13", name: "Solar Village", url: "https://solarvillage.xyz/", description: "Carbon credits for off-grid solar projects in Africa." },
    { id: "14", name: "SmarTrust", url: "https://smartrust.me/", description: "AI-powered escrow and arbitration for freelancers, agencies, and B2B work." },
    { id: "15", name: "SnapVote", url: "https://snapvote.org/", description: "Fast, trustworthy decision-making and polls for communities." },
    { id: "16", name: "SpareChange", url: "https://sparechange.tips/", description: "Tip anyone with QR codes and digital micro-payments." },
    { id: "17", name: "TCOIN", url: "https://tcoin.me/", description: "Toronto's local community currency pegged to transit tokens." }
  ];

  return (
    <div className="min-h-screen bg-gray-50 pt-16 pb-24">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center max-w-3xl mx-auto mb-16">
          <h1 className="text-4xl font-extrabold text-gray-900 sm:text-5xl">
            Our Ecosystem
          </h1>
          <p className="mt-6 text-xl text-gray-600 leading-relaxed">
            Projects around UBI Finder are shaping identity, trust, local economies, and coordination.<br className="hidden md:block" />
            UBI Finder does not sit alone. The broader ecosystem includes identity tools, community infrastructure, funding experiments, and trust layers that strengthen the same coordination thesis from different directions.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {projects.map((project) => (
            <Card key={project.id} className="border-gray-200 hover:border-green-300 hover:shadow-lg transition-all duration-300 h-full flex flex-col group bg-white">
              <CardContent className="p-6 flex flex-col flex-grow">
                <div className="flex justify-between items-start mb-4">
                  <h3 className="text-2xl font-bold text-gray-900 group-hover:text-green-700 transition-colors">{project.name}</h3>
                  <span className="text-xs font-bold text-gray-400 bg-gray-100 px-2.5 py-1 rounded-full">
                    {project.id}
                  </span>
                </div>
                <p className="text-gray-600 mb-8 flex-grow leading-relaxed">
                  {project.description}
                </p>
                <div className="mt-auto pt-4 border-t border-gray-100">
                  <a 
                    href={project.url} 
                    target="_blank" 
                    rel="noopener noreferrer"
                    className="inline-flex items-center text-sm font-bold text-green-700 hover:text-green-800"
                  >
                    Open Site
                    <ExternalLink className="ml-1.5 w-4 h-4 transition-transform group-hover:translate-x-0.5 group-hover:-translate-y-0.5" />
                  </a>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    </div>
  );
}
