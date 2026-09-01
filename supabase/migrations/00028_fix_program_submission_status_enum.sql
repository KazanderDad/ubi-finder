-- Repair the submission notification trigger created in migration 00015.
-- `program_status` defines `pending_approval`, not `pending`; the invalid enum
-- literal made inserts (including canonical seed replay) fail at runtime.

CREATE OR REPLACE FUNCTION public.handle_new_program_submission()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  IF NEW.verified = FALSE OR NEW.status = 'pending_approval' THEN
    INSERT INTO public.admin_notifications (type, title, message, program_id, submitter_id)
    VALUES (
      'program_submitted',
      'New Program Submitted for Review: ' || NEW.name,
      'A new program has been submitted by ' || COALESCE(NEW.submitter_email, 'a contributor') || ' and is awaiting verification.',
      NEW.id,
      auth.uid()
    );
  END IF;
  RETURN NEW;
END;
$$;
