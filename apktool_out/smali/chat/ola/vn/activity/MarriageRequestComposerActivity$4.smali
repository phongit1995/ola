.class Lchat/ola/vn/activity/MarriageRequestComposerActivity$4;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/MarriageRequestComposerActivity;->C()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/MarriageRequestComposerActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/MarriageRequestComposerActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity$4;->a:Lchat/ola/vn/activity/MarriageRequestComposerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public b_(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity$4;->a:Lchat/ola/vn/activity/MarriageRequestComposerActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->a(Lchat/ola/vn/activity/MarriageRequestComposerActivity;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object v0

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity$4;->a:Lchat/ola/vn/activity/MarriageRequestComposerActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->a(Lchat/ola/vn/activity/MarriageRequestComposerActivity;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setSelection(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
