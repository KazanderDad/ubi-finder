import React, { useState, useEffect } from "react";
import { supabase } from "@/lib/supabaseClient";
import { useAuth } from "@/lib/AuthContext";
import { useNavigate, Link } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
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
import { MessageSquare, Users, Megaphone, Send, Filter, Plus, Sparkles, Tag, ChevronDown, CheckCircle } from "lucide-react";
import { format, parseISO } from "date-fns";

export default function CommunityPage() {
  const { user, userProfile } = useAuth();
  const navigate = useNavigate();
  
  const [activeTab, setActiveTab] = useState("discussions");
  const [discussions, setDiscussions] = useState([]);
  const [announcements, setAnnouncements] = useState([]);
  const [programsList, setProgramsList] = useState([]);
  const [loading, setLoading] = useState(true);
  const [filter, setFilter] = useState("all");

  // 6b. Quick-post state
  const [isComposing, setIsComposing] = useState(false);
  const [newTitle, setNewTitle] = useState("");
  const [newContent, setNewContent] = useState("");
  const [newCategory, setNewCategory] = useState("program_experience");
  const [newProgramId, setNewProgramId] = useState("none");
  const [submitting, setSubmitting] = useState(false);
  const [postSuccess, setPostSuccess] = useState(false);
  const [postError, setPostError] = useState("");

  useEffect(() => {
    window.scrollTo(0, 0);
    fetchData();
  }, []);

  const fetchData = async () => {
    setLoading(true);
    try {
      const [dRes, aRes, pRes] = await Promise.all([
        supabase.from('community_discussions').select('*').order('created_at', { ascending: false }),
        supabase.from('community_announcements').select('*').order('is_pinned', { ascending: false }).order('created_at', { ascending: false }),
        supabase.from('programs').select('program_id, name')
      ]);

      if (!dRes.error && dRes.data) setDiscussions(dRes.data);
      if (!aRes.error && aRes.data) setAnnouncements(aRes.data);
      if (!pRes.error && pRes.data) setProgramsList(pRes.data);
    } catch (error) {
      console.error("Error loading community data:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleCreatePost = async (e) => {
    e.preventDefault();
    if (!newTitle.trim() || !newContent.trim()) return;

    if (!user?.id) {
      setPostError("You must be logged in to create a discussion.");
      return;
    }

    setSubmitting(true);
    setPostError("");

    try {
      const authorName = userProfile?.name || user.user_metadata?.full_name || user.user_metadata?.name || user.email?.split('@')[0] || "Community Member";
      const tags = [newCategory];
      if (newProgramId !== "none") {
        const found = programsList.find(p => p.program_id === parseInt(newProgramId, 10));
        if (found) tags.push(found.name);
      }

      const postPayload = {
        title: newTitle.trim(),
        content: newContent.trim(),
        category: newCategory,
        author_id: user.id,
        author_name: authorName,
        tags: tags,
        likes: 0,
        replies: 0
      };

      const { data, error } = await supabase
        .from('community_discussions')
        .insert([postPayload])
        .select()
        .single();

      if (error) throw error;

      if (data) {
        setDiscussions(prev => [data, ...prev]);
        setNewTitle("");
        setNewContent("");
        setNewProgramId("none");
        setIsComposing(false);
        setPostSuccess(true);
        setTimeout(() => setPostSuccess(false), 4000);
      }
    } catch (err) {
      console.error("Error creating discussion:", err);
      setPostError(err.message || "Failed to publish post. Please try again.");
    } finally {
      setSubmitting(false);
    }
  };

  const getFilteredDiscussions = () => {
    if (filter === "all") return discussions;
    return discussions.filter(d => d.category === filter);
  };

  const formatDate = (dateString) => {
    try {
      if (!dateString) return "";
      const date = parseISO(dateString);
      return format(date, 'MMM d, yyyy');
    } catch (error) {
      return "";
    }
  };

  const getInitials = (name) => {
    if (!name) return "U";
    return name
      .split(" ")
      .map(n => n[0])
      .join("")
      .toUpperCase()
      .slice(0, 2);
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
      <div className="max-w-5xl mx-auto space-y-8">
        
        {/* Page Header */}
        <div className="text-center">
          <div className="inline-block p-2 bg-green-100 rounded-full mb-3 shadow-inner">
            <Users className="w-7 h-7 text-green-700" />
          </div>
          <h1 className="text-3xl md:text-4xl font-extrabold text-green-950 mb-2">UBI Community Hub</h1>
          <p className="text-gray-600 max-w-2xl mx-auto text-sm leading-relaxed">
            Connect with basic income recipients, share application experiences, and exchange insights on global income pilots.
          </p>
        </div>

        {postSuccess && (
          <div className="p-4 bg-green-100 border border-green-300 text-green-900 rounded-xl text-sm font-medium flex items-center gap-2">
            <CheckCircle className="w-5 h-5 text-green-700" />
            Your discussion topic has been published successfully!
          </div>
        )}
        
        <Tabs value={activeTab} onValueChange={setActiveTab} className="w-full">
          <TabsList className="grid w-full grid-cols-3 mb-8 bg-white/90 border border-gray-200 shadow-sm rounded-xl p-1.5">
            <TabsTrigger 
              value="discussions"
              className="rounded-lg data-[state=active]:bg-green-700 data-[state=active]:text-white font-medium text-xs sm:text-sm transition-all"
            >
              <MessageSquare className="w-4 h-4 mr-2" />
              Discussions ({discussions.length})
            </TabsTrigger>
            <TabsTrigger 
              value="announcements"
              className="rounded-lg data-[state=active]:bg-green-700 data-[state=active]:text-white font-medium text-xs sm:text-sm transition-all"
            >
              <Megaphone className="w-4 h-4 mr-2" />
              Announcements ({announcements.length})
            </TabsTrigger>
            <TabsTrigger 
              value="guidelines"
              className="rounded-lg data-[state=active]:bg-green-700 data-[state=active]:text-white font-medium text-xs sm:text-sm transition-all"
            >
              <Sparkles className="w-4 h-4 mr-2" />
              Guidelines & Help
            </TabsTrigger>
          </TabsList>
          
          {/* DISCUSSIONS TAB */}
          <TabsContent value="discussions" className="space-y-6 mt-0">
            
            {/* 6b: Quick-Post Composer Card */}
            {user ? (
              <Card className="shadow-md border-green-200 bg-white/95 backdrop-blur-sm overflow-hidden">
                <CardHeader className="pb-3 bg-green-50/60 border-b border-green-100">
                  <div className="flex justify-between items-center">
                    <CardTitle className="text-base font-bold text-green-950 flex items-center gap-2">
                      <MessageSquare className="w-4 h-4 text-green-700" />
                      Start a Discussion or Ask a Question
                    </CardTitle>
                    <Button 
                      variant="ghost" 
                      size="sm" 
                      onClick={() => setIsComposing(!isComposing)}
                      className="text-xs text-green-700 hover:text-green-800"
                    >
                      {isComposing ? "Collapse" : "New Post +"}
                    </Button>
                  </div>
                </CardHeader>
                
                {isComposing && (
                  <CardContent className="pt-5">
                    <form onSubmit={handleCreatePost} className="space-y-4">
                      <Input
                        placeholder="Discussion Title / Question summary..."
                        value={newTitle}
                        onChange={(e) => setNewTitle(e.target.value)}
                        required
                        className="font-medium"
                      />

                      <Textarea
                        placeholder="Share your thoughts, application experiences, or questions with the community..."
                        value={newContent}
                        onChange={(e) => setNewContent(e.target.value)}
                        required
                        className="min-h-[100px] text-sm"
                      />

                      <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                        <div>
                          <label className="text-xs font-semibold text-gray-700 block mb-1">Category</label>
                          <Select value={newCategory} onValueChange={setNewCategory}>
                            <SelectTrigger className="w-full text-xs">
                              <SelectValue placeholder="Category" />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="program_experience">Program Experiences</SelectItem>
                              <SelectItem value="news">News & Policy Updates</SelectItem>
                              <SelectItem value="digital_ubi">Crypto / Digital UBI</SelectItem>
                              <SelectItem value="advice">Advice & Application Help</SelectItem>
                            </SelectContent>
                          </Select>
                        </div>

                        {/* 6c: Program-linked tag selector */}
                        <div>
                          <label className="text-xs font-semibold text-gray-700 block mb-1">Link to Program (Optional)</label>
                          <Select value={newProgramId} onValueChange={setNewProgramId}>
                            <SelectTrigger className="w-full text-xs">
                              <SelectValue placeholder="Tag a program" />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="none">No Specific Program</SelectItem>
                              {programsList.map(p => (
                                <SelectItem key={p.program_id} value={p.program_id.toString()}>
                                  {p.name}
                                </SelectItem>
                              ))}
                            </SelectContent>
                          </Select>
                        </div>
                      </div>

                      {postError && (
                        <p className="text-xs text-red-600 bg-red-50 p-2.5 rounded-lg border border-red-200">
                          {postError}
                        </p>
                      )}

                      <div className="flex justify-end gap-2 pt-2">
                        <Button 
                          type="button" 
                          variant="ghost" 
                          size="sm" 
                          onClick={() => setIsComposing(false)}
                          className="text-xs"
                        >
                          Cancel
                        </Button>
                        <Button 
                          type="submit" 
                          size="sm"
                          disabled={submitting}
                          className="bg-green-700 hover:bg-green-800 text-white font-semibold text-xs px-5 shadow-sm"
                        >
                          <Send className="w-3.5 h-3.5 mr-1.5" />
                          {submitting ? "Posting..." : "Publish Post"}
                        </Button>
                      </div>
                    </form>
                  </CardContent>
                )}
              </Card>
            ) : (
              <div className="p-4 bg-green-50/80 rounded-xl border border-green-200 text-center flex flex-col sm:flex-row items-center justify-between gap-3 text-sm">
                <span className="text-gray-700 font-medium">
                  Have a question or experience to share? Sign in to join the conversation.
                </span>
                <Button 
                  size="sm"
                  className="bg-green-700 hover:bg-green-800 text-white text-xs px-4"
                  onClick={() => navigate('/login')}
                >
                  Sign In to Post
                </Button>
              </div>
            )}

            {/* Filter Bar */}
            <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 pt-2">
              <h2 className="text-lg font-bold text-green-950">Recent Conversations</h2>
              
              <div className="flex items-center gap-2">
                <Filter className="w-4 h-4 text-gray-500" />
                <Select value={filter} onValueChange={setFilter}>
                  <SelectTrigger className="w-[180px] bg-white text-xs h-9">
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
            
            {/* Discussions Feed (6a) */}
            <div className="space-y-4">
              {getFilteredDiscussions().map((discussion) => (
                <Card key={discussion.id} className="hover:shadow-md transition-all duration-200 border-gray-200/80 bg-white/90">
                  <CardContent className="p-6">
                    <div className="flex items-start gap-4">
                      {/* 6a: Author Avatar */}
                      <Avatar className="h-10 w-10 border border-green-200 flex-shrink-0">
                        <AvatarFallback className="bg-green-100 text-green-900 font-bold text-xs">
                          {getInitials(discussion.author_name)}
                        </AvatarFallback>
                      </Avatar>
                      
                      <div className="flex-1 space-y-2">
                        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-1">
                          <h3 className="font-bold text-base text-green-950 hover:text-green-800 transition-colors">
                            {discussion.title}
                          </h3>
                          {/* 6a: Relative/formatted timestamp */}
                          <span className="text-xs text-gray-400 font-medium">
                            {formatDate(discussion.created_at)}
                          </span>
                        </div>
                        
                        <div className="flex items-center text-xs text-gray-500 gap-2">
                          <span className="font-semibold text-gray-700">{discussion.author_name}</span>
                          {discussion.category && (
                            <>
                              <span>&bull;</span>
                              <span className="capitalize text-green-700 bg-green-50 px-2 py-0.5 rounded font-medium text-[11px]">
                                {discussion.category.replace('_', ' ')}
                              </span>
                            </>
                          )}
                        </div>
                        
                        <p className="text-gray-700 text-sm leading-relaxed whitespace-pre-line pt-1">
                          {discussion.content}
                        </p>
                        
                        {/* Tags */}
                        {discussion.tags && discussion.tags.length > 0 && (
                          <div className="flex flex-wrap gap-1.5 pt-2">
                            {discussion.tags.map((tag, idx) => (
                              <Badge 
                                key={idx} 
                                variant="secondary"
                                className="bg-gray-100 text-gray-600 text-[10px] font-normal"
                              >
                                #{tag}
                              </Badge>
                            ))}
                          </div>
                        )}
                        
                        {/* 6a: Reply count */}
                        <div className="flex items-center gap-4 text-xs text-gray-500 pt-2 border-t border-gray-100">
                          <div className="flex items-center gap-1 font-medium">
                            <MessageSquare className="w-3.5 h-3.5 text-green-600" />
                            {discussion.replies || 0} {discussion.replies === 1 ? "response" : "responses"}
                          </div>
                        </div>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              ))}
              
              {getFilteredDiscussions().length === 0 && (
                <div className="text-center py-12 bg-white rounded-2xl border border-dashed border-gray-300">
                  <MessageSquare className="w-12 h-12 text-gray-300 mx-auto mb-3" />
                  <h3 className="text-base font-bold text-gray-800">No discussions found in this topic</h3>
                  <p className="text-xs text-gray-500 mt-1">Be the first to share your thoughts or start a new thread above.</p>
                </div>
              )}
            </div>
          </TabsContent>
          
          {/* ANNOUNCEMENTS TAB */}
          <TabsContent value="announcements" className="mt-0 space-y-4">
            {announcements.map((announcement) => (
              <Card 
                key={announcement.id}
                className={`border shadow-sm ${announcement.is_pinned ? 'border-green-300 bg-green-50/50' : 'bg-white'}`}
              >
                <CardHeader className="pb-3">
                  <div className="flex justify-between items-start">
                    <div>
                      <CardTitle className="text-base font-bold text-green-950 flex items-center gap-2">
                        {announcement.is_pinned && (
                          <Badge className="bg-green-700 text-white text-[10px]">Pinned</Badge>
                        )}
                        {announcement.title}
                      </CardTitle>
                      <CardDescription className="text-xs text-gray-500 mt-1">
                        {formatDate(announcement.created_at)}
                      </CardDescription>
                    </div>
                  </div>
                </CardHeader>
                <CardContent>
                  <p className="text-sm text-gray-700 leading-relaxed">{announcement.content}</p>
                </CardContent>
              </Card>
            ))}
          </TabsContent>
          
          {/* GUIDELINES TAB */}
          <TabsContent value="guidelines" className="mt-0">
            <Card className="bg-white/95 border-green-100 shadow-sm">
              <CardHeader>
                <CardTitle className="text-lg font-bold text-green-950">Community Participation Standards</CardTitle>
                <CardDescription className="text-xs">
                  We strive to maintain an open, welcoming, and safe hub for all basic income recipients and researchers.
                </CardDescription>
              </CardHeader>
              <CardContent className="space-y-4 text-sm text-gray-700">
                <div className="p-3 bg-gray-50 rounded-xl border border-gray-100">
                  <h4 className="font-bold text-green-900 text-sm mb-1">1. Respectful & Constructive Collaboration</h4>
                  <p className="text-xs text-gray-600">
                    Treat fellow participants with dignity. Constructive criticism is encouraged, but harassment, discrimination, or abusive language will result in account restriction.
                  </p>
                </div>
                <div className="p-3 bg-gray-50 rounded-xl border border-gray-100">
                  <h4 className="font-bold text-green-900 text-sm mb-1">2. Keep Personal Information Safe</h4>
                  <p className="text-xs text-gray-600">
                    Never share your private banking details, seed phrases, national identification numbers, or home address in public forum discussions.
                  </p>
                </div>
                <div className="p-3 bg-gray-50 rounded-xl border border-gray-100">
                  <h4 className="font-bold text-green-900 text-sm mb-1">3. Verify Sources & Official Links</h4>
                  <p className="text-xs text-gray-600">
                    When announcing new basic income pilots, please link to official government, non-profit, or foundation websites.
                  </p>
                </div>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
