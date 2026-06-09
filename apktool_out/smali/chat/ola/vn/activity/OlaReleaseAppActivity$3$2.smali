.class Lchat/ola/vn/activity/OlaReleaseAppActivity$3$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/media/MediaPlayer$OnPreparedListener;


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

    iput-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$2;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPrepared(Landroid/media/MediaPlayer;)V
    .locals 1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    const/high16 v0, 0x3f800000    # 1.0f

    :goto_0
    invoke-virtual {p1, v0, v0}, Landroid/media/MediaPlayer;->setVolume(FF)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    :catch_0
    :goto_1
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$2;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->o:Landroid/view/View;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$2;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->o:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$2;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/VideoView;->setBackgroundColor(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$2;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    invoke-virtual {p1, v0}, Landroid/widget/VideoView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$2;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->m:Lchat/ola/vn/view/OlaRatioImageView;

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
