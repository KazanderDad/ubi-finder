





import { supabase } from "@/lib/supabaseClient";
import React, { useState, useEffect } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Textarea } from "@/components/ui/textarea";
import { format, parseISO } from "date-fns";
import { ChevronLeft, Calendar, Tag, User as UserIcon, Send } from "lucide-react";
import ReactMarkdown from "react-markdown";
import { createPageUrl } from "@/utils";
import { Avatar, AvatarImage, AvatarFallback } from "@/components/ui/avatar";


export default function BlogPostPage() {
  const [post, setPost] = useState(null);
  const [comments, setComments] = useState([]);
  const [programs, setPrograms] = useState([]);
  const [newComment, setNewComment] = useState("");
  const [loading, setLoading] = useState(true);
  const [user, setUser] = useState(null);
  const location = useLocation();
  const navigate = useNavigate();
  const [submittingComment, setSubmittingComment] = useState(false);
  const [userProfiles, setUserProfiles] = useState({});  // Add this state for caching profiles

  const { postId } = location.state || {};
  const isFromDashboard = location.state?.from === 'dashboard';

  useEffect(() => {
    if (!postId) {
      navigate(createPageUrl("Blog"));
      return;
    }
    loadData();
  }, [postId]);

  // Update loadData to also fetch user profiles
  const loadData = async () => {
    try {
      const [postRes, programsRes, commentsRes, userRes] = await Promise.all([
        supabase.from('blog_posts').select('*').eq('id', postId).single(),
        supabase.from('programs').select('*'),
        supabase.from('comments').select('*').eq('blog_post_id', postId).order('created_date', { ascending: true }),
        supabase.auth.getUser()
      ]);

      const postData = postRes.data;
      const allPrograms = programsRes.data || [];
      const allComments = commentsRes.data || [];
      const userData = userRes.data?.user || null;

      setPost(postData);
      setPrograms(allPrograms);
      setComments(allComments);
      setUser(userData);

      if (allComments.length > 0) {
        const emails = allComments.map(c => c.author_email).filter(Boolean);
        if (emails.length > 0) {
          const { data: profiles } = await supabase.from('user_profiles').select('*').in('created_by', emails);
          const profileMap = {};
          if (profiles) {
            profiles.forEach(profile => {
              if (profile.created_by) {
                profileMap[profile.created_by] = profile;
              }
            });
          }
          setUserProfiles(prev => ({...prev, ...profileMap}));
        }
      }

      if (userData) {
        const { data: userProfileList } = await supabase.from('user_profiles').select('*').eq('created_by', userData.email);
        if (userProfileList && userProfileList.length > 0) {
          setUserProfiles(prev => ({
            ...prev,
            [userData.email]: userProfileList[0]
          }));
        }
      }

      setLoading(false);
    } catch (error) {
      console.error("Error loading blog post:", error);
      setLoading(false);
    }
  };

  // Default avatar image to use when user has no profile picture
  const DEFAULT_AVATAR = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScfYIGxbXeB6QQNQ6juhTxDVvfc1850IBMtQ&s";

  const getProgramsForPost = () => {
    if (!post?.related_programs) return [];
    return post.related_programs
      .map(programId => programs.find(p => p.program_id === parseInt(programId)))
      .filter(Boolean);
  };

  const handleSubmitComment = async (e) => {
    e.preventDefault();
    if (!newComment.trim() || !user) return;

    try {
      setSubmittingComment(true);
      (await supabase.from('comments').insert([{
        blog_post_id: postId,
        content: newComment,
        author_name: user.full_name,
        author_email: user.email
      }]).select().single()).data;

      setNewComment("");
      const { data: updatedComments } = await supabase.from('comments').select('*').eq('blog_post_id', postId).order('created_date', { ascending: true });
      setComments(updatedComments);
      
      // Fetch user profile and update state after comment submission
      const userProfileList = (await supabase.from('user_profiles').select('*').match({ created_by: user.email })).data;
      if (userProfileList.length > 0) {
        setUserProfiles(prev => ({
          ...prev,
          [user.email]: userProfileList[0]
        }));
      }

    } catch (error) {
      console.error("Error submitting comment:", error);
    } finally {
      setSubmittingComment(false);
    }
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

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-green-700"></div>
      </div>
    );
  }

  if (!post) {
    return (
      <div className="text-center py-12">
        <p className="text-gray-500">Blog post not found.</p>
      </div>
    );
  }

  const getInitials = (name) => {
    if (!name) return "?";
    return name
      .split(" ")
      .map(n => n[0])
      .join("")
      .toUpperCase();
  };

  return (
    <>
      <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-12">
        <div className="max-w-4xl mx-auto">
          <Button
            variant="ghost"
            className="mb-8 text-green-700 hover:text-green-800 hover:bg-green-50"
            onClick={() => navigate(createPageUrl(isFromDashboard ? "Dashboard" : "Blog"))}
          >
            <ChevronLeft className="w-4 h-4 mr-2" />
            {isFromDashboard ? "Back to Dashboard" : "Back to All Articles"}
          </Button>

          <Card className="overflow-hidden">
            {post.image_url && (
              <img 
                src={post.image_url} 
                alt={post.title}
                className="w-full h-64 object-cover"
              />
            )}
            <CardContent className="p-8">
              <h1 className="text-3xl font-bold text-green-900 mb-4">
                {post.title}
              </h1>

              <div className="flex items-center gap-4 text-sm text-gray-600 mb-6">
                <div className="flex items-center gap-1">
                  <Calendar className="w-4 h-4" />
                  {formatDate(post.posted_date)}
                </div>
                <div className="flex items-center gap-1">
                  <UserIcon className="w-4 h-4" />
                  {post.author}
                </div>
              </div>

              {getProgramsForPost().length > 0 && (
                <div className="flex flex-wrap gap-2 mb-6">
                  {getProgramsForPost().map(program => (
                    <Badge key={program.program_id} variant="outline">
                      {program.name}
                    </Badge>
                  ))}
                </div>
              )}

              <div className="prose max-w-none mb-8">
                <ReactMarkdown>{post.content}</ReactMarkdown>
              </div>

              {post.tags && post.tags.length > 0 && (
                <div className="flex items-center gap-2 pt-6 border-t">
                  <Tag className="w-4 h-4 text-gray-500" />
                  <div className="flex flex-wrap gap-2">
                    {post.tags.map(tag => (
                      <Badge 
                        key={tag} 
                        variant="secondary"
                        className="bg-gray-100"
                      >
                        {tag}
                      </Badge>
                    ))}
                  </div>
                </div>
              )}
            </CardContent>
          </Card>

          {/* Comments Section */}
          <Card className="mt-8">
            <CardHeader>
              <CardTitle>Comments ({comments.length})</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-6">
                {comments.map(comment => (
                  <div key={comment.id} className="p-4 bg-white rounded-lg border">
                    <div className="flex gap-4">
                      <Avatar className="h-10 w-10 border-2 border-green-100">
                        {userProfiles[comment.author_email]?.profile_picture ? (
                          <AvatarImage 
                            src={userProfiles[comment.author_email].profile_picture} 
                            alt={comment.author_name}
                          />
                        ) : (
                          <>
                            <AvatarImage 
                              src={DEFAULT_AVATAR}
                              alt="Default avatar"
                            />
                            <AvatarFallback className="bg-green-50 text-green-700">
                              {getInitials(comment.author_name)}
                            </AvatarFallback>
                          </>
                        )}
                      </Avatar>
                      <div className="flex-1">
                        <div className="flex justify-between items-start mb-2">
                          <span className="font-medium text-green-900">
                            {comment.author_name}
                          </span>
                          <span className="text-sm text-gray-500">
                            {formatDate(comment.created_date)}
                          </span>
                        </div>
                        <p className="text-gray-700">{comment.content}</p>
                      </div>
                    </div>
                  </div>
                ))}

                {user ? (
                  <form onSubmit={handleSubmitComment} className="mt-6">
                    <div className="flex gap-4">
                      <Avatar className="h-10 w-10 border-2 border-green-100">
                        {userProfiles[user.email]?.profile_picture ? (
                          <AvatarImage 
                            src={userProfiles[user.email].profile_picture} 
                            alt={user.full_name}
                          />
                        ) : (
                          <>
                            <AvatarImage 
                              src={DEFAULT_AVATAR}
                              alt="Default avatar"
                            />
                            <AvatarFallback className="bg-green-50 text-green-700">
                              {getInitials(user.full_name)}
                            </AvatarFallback>
                          </>
                        )}
                      </Avatar>
                      <div className="flex-1 space-y-4">
                        <Textarea
                          placeholder="Add a comment..."
                          value={newComment}
                          onChange={(e) => setNewComment(e.target.value)}
                          className="min-h-[100px]"
                        />
                        <div className="flex justify-end">
                          <Button 
                            type="submit" 
                            className="bg-green-700 hover:bg-green-800"
                            disabled={submittingComment || !newComment.trim()}
                          >
                            {submittingComment ? (
                              <div className="animate-spin rounded-full h-4 w-4 border-2 border-b-0 border-white"></div>
                            ) : (
                              <>
                                <Send className="w-4 h-4 mr-2" />
                                Post Comment
                              </>
                            )}
                          </Button>
                        </div>
                      </div>
                    </div>
                  </form>
                ) : (
                  <div className="text-center py-4">
                    <p className="text-gray-500">
                      Please log in to leave a comment.
                    </p>
                  </div>
                )}
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
      
    </>
  );
}

