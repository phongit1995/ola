.class Lchat/ola/vn/note/OlaNoteComposerActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/note/OlaNoteComposerActivity;->d(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/note/OlaNoteComposerActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/note/OlaNoteComposerActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/note/OlaNoteComposerActivity$2;->a:Lchat/ola/vn/note/OlaNoteComposerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity$2;->a:Lchat/ola/vn/note/OlaNoteComposerActivity;

    invoke-static {v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->b(Lchat/ola/vn/note/OlaNoteComposerActivity;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->isFocused()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/note/OlaNoteComposerActivity$2;->a:Lchat/ola/vn/note/OlaNoteComposerActivity;

    invoke-static {v0}, Lchat/ola/vn/note/OlaNoteComposerActivity;->a(Lchat/ola/vn/note/OlaNoteComposerActivity;)Lchat/ola/vn/view/OlaTypingSuggestedText;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->requestFocus()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
