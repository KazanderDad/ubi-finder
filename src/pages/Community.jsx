
import React, { useState, useEffect } from "react";
import { supabase } from "@/lib/supabaseClient";
import { useAuth } from "@/lib/AuthContext";
import { useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Textarea } from "@/components/ui/textarea";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarImage, AvatarFallback } from "@/components/ui/avatar";
import { MessageSquare, Users, Megaphone, Send, Filter } from "lucide-react";
import { format, parseISO } from "date-fns";

export default function CommunityPage() {
  const { user, userProfile } = useAuth();
  const navigate = useNavigate();
  
  const [activeTab, setActiveTab] = useState("discussions");
  const [discussions, setDiscussions] = useState([]);
  const [announcements, setAnnouncements] = useState([]);
  const [loading, setLoading] = useState(true);
  const [filter, setFilter] = useState("all");
  
  useEffect(() => {
    window.scrollTo(0, 0);
    fetchData();
  }, []);

  const fetchData = async () => {
    setLoading(true);
    try {
      const { data: dData, error: dError } = await supabase
        .from('community_discussions')
        .select('*')
        .order('created_at', { ascending: false });
        
      if (!dError && dData) {
        setDiscussions(dData);
      }

      const { data: aData, error: aError } = await supabase
        .from('community_announcements')
        .select('*')
        .order('is_pinned', { ascending: false })
        .order('created_at', { ascending: false });

      if (!aError && aData) {
        setAnnouncements(aData);
      }
    } catch (error) {
      console.error("Error loading community data:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleFilterChange = (value) => {
    setFilter(value);
  };

  const getFilteredDiscussions = () => {
    if (filter === "all") return discussions;
    return discussions.filter(discussion => discussion.category === filter);
  };

  const formatDate = (dateString) => {
    try {
      if (!dateString) return "Unknown date";
      const date = parseISO(dateString);
      return format(date, 'MMM d, yyyy');
    } catch (error) {
      return "Unknown date";
    }
  };

  const getInitials = (name) => {
    if (!name) return "?";
    return name
      .split(" ")
      .map(n => n[0])
      .join("")
      .toUpperCase();
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[calc(100vh-64px)]">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-green-700"></div>
      </div>
    );
  }

  return (
    <div className="min-h-[calc(100vh-64px)] bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-12">
      <div className="max-w-5xl mx-auto">
        <div className="text-center mb-8">
          <div className="inline-block p-2 bg-green-100 rounded-full mb-4">
            <Users className="w-8 h-8 text-green-700" />
          </div>
          <h1 className="text-3xl font-bold text-green-900 mb-2">UBI Community Hub</h1>
          <p className="text-gray-600 max-w-2xl mx-auto">
            Connect with others receiving Universal Basic Income, share experiences, and stay updated on the latest programs worldwide.
          </p>
        </div>
        
        <Tabs value={activeTab} onValueChange={setActiveTab} className="w-full">
          <TabsList className="grid w-full grid-cols-3 mb-8 bg-white border border-gray-100 shadow-sm rounded-lg p-1">
            <TabsTrigger 
              value="discussions"
              className="rounded-md data-[state=active]:bg-green-50 data-[state=active]:text-green-900 data-[state=active]:font-medium"
            >
              <MessageSquare className="w-4 h-4 mr-2" />
              Discussions
            </TabsTrigger>
            <TabsTrigger 
              value="announcements"
              className="rounded-md data-[state=active]:bg-green-50 data-[state=active]:text-green-900 data-[state=active]:font-medium"
            >
              <Megaphone className="w-4 h-4 mr-2" />
              Announcements
            </TabsTrigger>
            <TabsTrigger 
              value="members"
              className="rounded-md data-[state=active]:bg-green-50 data-[state=active]:text-green-900 data-[state=active]:font-medium"
            >
              <Users className="w-4 h-4 mr-2" />
              Members
            </TabsTrigger>
          </TabsList>
          
          <TabsContent value="discussions" className="mt-0">
            <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-6 gap-4">
              <h2 className="text-xl font-semibold text-gray-800">Recent Conversations</h2>
              
              <div className="flex items-center gap-2">
                <Filter className="w-4 h-4 text-gray-500" />
                <Select value={filter} onValueChange={handleFilterChange}>
                  <SelectTrigger className="w-[180px] bg-white">
                    <SelectValue placeholder="Filter by topic" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">All Topics</SelectItem>
                    <SelectItem value="program_experience">Program Experiences</SelectItem>
                    <SelectItem value="news">News & Updates</SelectItem>
                    <SelectItem value="digital_ubi">Digital UBI</SelectItem>
                    <SelectItem value="advice">Advice & Support</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
            
            <div className="space-y-4">
              {getFilteredDiscussions().map((discussion) => (
                <Card key={discussion.id} className="hover:shadow-md transition-shadow">
                  <CardContent className="p-6">
                    <div className="flex gap-4">
                      <Avatar className="h-10 w-10">
                        <AvatarFallback className="bg-green-100 text-green-800">
                          {getInitials(discussion.author_name)}
                        </AvatarFallback>
                      </Avatar>
                      
                      <div className="flex-1">
                        <div className="flex justify-between mb-1">
                          <h3 className="font-medium text-lg text-green-900">{discussion.title}</h3>
                          <span className="text-sm text-gray-500">{formatDate(discussion.created_at)}</span>
                        </div>
                        
                        <div className="flex items-center text-sm text-gray-600 mb-3">
                          <span className="font-medium">{discussion.author_name}</span>
                        </div>
                        
                        <p className="text-gray-700 mb-4">{discussion.content}</p>
                        
                        <div className="flex flex-wrap gap-2 mb-4">
                          {discussion.tags.map(tag => (
                            <Badge 
                              key={tag} 
                              variant="secondary"
                              className="bg-gray-100"
                            >
                              #{tag}
                            </Badge>
                          ))}
                        </div>
                        
                        <div className="flex items-center gap-4 text-sm text-gray-600">
                          <div className="flex items-center gap-1">
                            <MessageSquare className="w-4 h-4" />
                            {discussion.replies} replies
                          </div>
                        </div>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              ))}
              
              {getFilteredDiscussions().length === 0 && (
                <div className="text-center py-12 bg-white rounded-lg border border-dashed border-gray-300">
                  <MessageSquare className="w-12 h-12 text-gray-300 mx-auto mb-3" />
                  <h3 className="text-lg font-medium text-gray-900">No discussions found</h3>
                  <p className="text-gray-500">Try changing your filter to see more results.</p>
                </div>
              )}
            </div>
          </TabsContent>
          
          <TabsContent value="announcements" className="mt-0">
            {announcements.map((announcement) => (
              <Card 
                key={announcement.id}
                className={`mb-6 ${announcement.is_pinned ? 'border-green-300 bg-green-50' : ''}`}
              >
                <CardHeader>
                  <div className="flex justify-between items-start">
                    <div>
                      <CardTitle className="flex items-center gap-2">
                        {announcement.is_pinned && (
                          <Badge className="bg-green-600">Pinned</Badge>
                        )}
                        {announcement.title}
                      </CardTitle>
                      <CardDescription>{formatDate(announcement.created_at)}</CardDescription>
                    </div>
                  </div>
                </CardHeader>
                <CardContent>
                  <p>{announcement.content}</p>
                </CardContent>
              </Card>
            ))}
            {announcements.length === 0 && (
              <div className="text-center py-12 bg-white rounded-lg border border-dashed border-gray-300">
                <Megaphone className="w-12 h-12 text-gray-300 mx-auto mb-3" />
                <h3 className="text-lg font-medium text-gray-900">No announcements</h3>
              </div>
            )}
          </TabsContent>
          
          <TabsContent value="members" className="mt-0">
            <Card>
              <CardContent className="p-8 text-center">
                <Users className="w-16 h-16 text-green-100 mx-auto mb-4" />
                <h3 className="text-xl font-medium text-gray-700 mb-2">Member Directory Coming Soon</h3>
                <p className="text-gray-600 mb-6">
                  Our member directory is under development. Soon you'll be able to connect with others in the UBI community.
                </p>
                <Button className="bg-green-700 hover:bg-green-800">
                  Join the Waitlist
                </Button>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
        
        {user ? (
          <Card className="mb-8 mt-8">
            <CardHeader>
              <CardTitle>Post a Response</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="flex gap-4">
                <Avatar className="h-10 w-10">
                  {userProfile?.profile_picture ? (
                    <AvatarImage src={userProfile.profile_picture} />
                  ) : (
                    <AvatarFallback className="bg-green-100 text-green-800">
                      {getInitials(user?.email || "U")}
                    </AvatarFallback>
                  )}
                </Avatar>
                
                <div className="flex-1 space-y-4">
                  <Textarea
                    placeholder="Share your thoughts with the community..."
                    className="min-h-[120px]"
                  />
                  <div className="flex justify-between items-center">
                    <Select>
                      <SelectTrigger className="w-[180px]">
                        <SelectValue placeholder="Select category" />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="program_experience">Program Experience</SelectItem>
                        <SelectItem value="news">News & Updates</SelectItem>
                        <SelectItem value="digital_ubi">Digital UBI</SelectItem>
                        <SelectItem value="advice">Advice & Support</SelectItem>
                      </SelectContent>
                    </Select>
                    <Button className="bg-green-700 hover:bg-green-800">
                      <Send className="w-4 h-4 mr-2" />
                      Post
                    </Button>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>
        ) : (
          <Card className="mb-8 mt-8">
            <CardContent className="p-6 text-center">
              <p className="mb-4 text-gray-600">
                Sign in to join the conversation and connect with other UBI community members.
              </p>
              <Button 
                className="bg-green-700 hover:bg-green-800"
                onClick={() => navigate('/login?view=signin')}
              >
                Sign In to Participate
              </Button>
            </CardContent>
          </Card>
        )}
        
        <Card className="mb-8 mt-8">
          <CardHeader>
            <CardTitle>Community Guidelines</CardTitle>
            <CardDescription>
              Please follow these guidelines to ensure a respectful and productive community environment
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <h3 className="font-medium text-green-900 mb-1">Be Respectful</h3>
              <p className="text-gray-600">
                Treat everyone with respect. No personal attacks, harassment, or hate speech.
              </p>
            </div>
            <div>
              <h3 className="font-medium text-green-900 mb-1">Stay On Topic</h3>
              <p className="text-gray-600">
                Keep discussions focused on Universal Basic Income and related topics.
              </p>
            </div>
            <div>
              <h3 className="font-medium text-green-900 mb-1">Verify Information</h3>
              <p className="text-gray-600">
                When sharing program details or news, please provide sources when possible.
              </p>
            </div>
            <div>
              <h3 className="font-medium text-green-900 mb-1">Protect Privacy</h3>
              <p className="text-gray-600">
                Don't share personal or financial information about yourself or others.
              </p>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
