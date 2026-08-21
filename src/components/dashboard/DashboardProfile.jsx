import React from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { User, Edit, MapPin, Users, Wallet, CreditCard, DollarSign, Eye } from "lucide-react";
import { createPageUrl } from "@/utils";
import { Link } from "react-router-dom";

// Default avatar image to use when user has no profile picture
const DEFAULT_AVATAR = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScfYIGxbXeB6QQNQ6juhTxDVvfc1850IBMtQ&s";

export default function DashboardProfile({ user, profile, showEditButton = true }) {
  return (
    <Card>
      <CardHeader className="flex flex-row items-center justify-between">
        <CardTitle className="flex items-center gap-2">
          <User className="w-5 h-5 text-green-700" />
          My Profile
        </CardTitle>
        {showEditButton && (
          <div className="flex gap-2">
            <Link to={createPageUrl("Profile")}>
              <Button
                className="bg-green-700 hover:bg-green-800 text-white"
                size="sm"
              >
                <Eye className="w-4 h-4 mr-2" />
                View Profile
              </Button>
            </Link>
            <Link to="/My-Report">
              <Button
                variant="outline"
                className="border-green-600 text-green-700 hover:bg-green-50"
                size="sm"
              >
                <Edit className="w-4 h-4 mr-2" />
                Edit Profile &rarr;
              </Button>
            </Link>
          </div>
        )}
      </CardHeader>
      <CardContent>
        <div className="grid grid-cols-2 gap-4">
          <div className="flex items-center gap-2">
            <MapPin className="w-4 h-4 text-green-600 shrink-0" />
            <span className="text-sm text-green-900">
              {profile?.state ? `${profile.state}, ${profile.country}` : profile?.country}
            </span>
          </div>
          
          <div className="flex items-center gap-2">
            <Users className="w-4 h-4 text-green-600 shrink-0" />
            <span className="text-sm text-green-900">
              {profile?.household_size} people
            </span>
          </div>
          
          <div className="flex items-center gap-2">
            <DollarSign className="w-4 h-4 text-green-600 shrink-0" />
            <span className="text-sm text-green-900">
              {profile?.income_range}
            </span>
          </div>
          
          <div className="flex items-center gap-2">
            <Wallet className="w-4 h-4 text-green-600 shrink-0" />
            <span className="text-sm text-green-900">
              Min: ${profile?.min_monthly_payment || '0'}/mo
            </span>
          </div>
          
          <div className="col-span-2 flex items-start gap-2">
            <CreditCard className="w-4 h-4 text-green-600 shrink-0 mt-0.5" />
            <div className="text-sm text-green-900">
              {profile?.accepts_digital_currency && profile?.accepts_foreign_currency ? (
                "Accepts digital & foreign currencies"
              ) : profile?.accepts_digital_currency ? (
                "Accepts digital currency"
              ) : profile?.accepts_foreign_currency ? (
                "Accepts foreign currency"
              ) : (
                "Standard payments only"
              )}
            </div>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}

