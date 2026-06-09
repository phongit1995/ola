.class Lchat/ola/vn/activity/OlaReleaseAppActivity$3$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/media/MediaPlayer$OnCompletionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a(Ljava/lang/String;Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaReleaseAppActivity$3;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCompletion(Landroid/media/MediaPlayer;)V
    .locals 2

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->o:Landroid/view/View;

    const/16 v0, 0x8

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->o:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    invoke-virtual {p1, v0}, Landroid/widget/VideoView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->m:Lchat/ola/vn/view/OlaRatioImageView;

    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->k:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->l:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->B()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
