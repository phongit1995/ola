.class Lchat/ola/vn/activity/OlaReleaseAppActivity$3$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/media/MediaPlayer$OnErrorListener;


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

    iput-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$1;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError(Landroid/media/MediaPlayer;II)Z
    .locals 0

    const/4 p1, 0x0

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$1;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    const/16 p3, 0x8

    invoke-virtual {p2, p3}, Landroid/widget/VideoView;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$1;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaReleaseAppActivity;->m:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {p2, p1}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$1;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaReleaseAppActivity;->o:Landroid/view/View;

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$1;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaReleaseAppActivity;->o:Landroid/view/View;

    invoke-virtual {p2, p3}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$1;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaReleaseAppActivity;->k:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {p2, p1}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$1;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaReleaseAppActivity;->l:Landroid/view/View;

    invoke-virtual {p2, p3}, Landroid/view/View;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$1;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    invoke-virtual {p2}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->B()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$1;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity$3;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    const/4 p3, 0x0

    invoke-static {p2, p3}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->a(Lchat/ola/vn/activity/OlaReleaseAppActivity;Ljava/lang/String;)Ljava/lang/String;

    return p1
.end method
