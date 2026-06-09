.class Lchat/ola/vn/activity/MarriageRequestComposerActivity$5;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/MarriageRequestComposerActivity;->E()Z
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

    iput-object p1, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity$5;->a:Lchat/ola/vn/activity/MarriageRequestComposerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    if-nez p2, :cond_0

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/activity/MarriageRequestComposerActivity$5;->a:Lchat/ola/vn/activity/MarriageRequestComposerActivity;

    invoke-virtual {p2}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->finish()V

    :cond_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
