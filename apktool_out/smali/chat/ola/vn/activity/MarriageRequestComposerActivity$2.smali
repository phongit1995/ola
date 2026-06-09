.class Lchat/ola/vn/activity/MarriageRequestComposerActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/MarriageRequestComposerActivity;->onCreate(Landroid/os/Bundle;)V
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

    iput-object p1, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity$2;->a:Lchat/ola/vn/activity/MarriageRequestComposerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity$2;->a:Lchat/ola/vn/activity/MarriageRequestComposerActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->a(Lchat/ola/vn/activity/MarriageRequestComposerActivity;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->requestFocus()Z

    return-void
.end method
