.class Lchat/ola/vn/activity/OlaReleaseAppActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/x/d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaReleaseAppActivity;->f(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaReleaseAppActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaReleaseAppActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/VideoView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->m:Lchat/ola/vn/view/OlaRatioImageView;

    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->o:Landroid/view/View;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->o:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->k:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->l:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->B()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->a(Lchat/ola/vn/activity/OlaReleaseAppActivity;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/x/c;",
            ">;)V"
        }
    .end annotation

    if-eqz p2, :cond_4

    :try_start_0
    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p1

    if-lez p1, :cond_4

    const/4 p1, 0x0

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/x/c;

    iget-short v2, v1, Lchat/ola/vn/x/c;->d:S

    const/16 v3, 0x500

    if-ne v2, v3, :cond_0

    move-object p1, v1

    :cond_1
    const/4 v0, 0x0

    if-nez p1, :cond_2

    invoke-interface {p2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/x/c;

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    invoke-virtual {p2, v0}, Landroid/widget/VideoView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-static {}, Lcom/mg/ola/common/d/g;->g()Z

    move-result p2

    if-eqz p2, :cond_3

    iget-object p2, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->m:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaRatioImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {p2, v1}, Landroid/widget/VideoView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    goto :goto_0

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->m:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaRatioImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {p2, v1}, Landroid/widget/VideoView;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    :try_start_2
    iget-object p2, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    invoke-virtual {p2, v0}, Landroid/widget/VideoView;->setBackgroundColor(I)V

    :goto_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    iget-object p1, p1, Lchat/ola/vn/x/c;->b:Ljava/lang/String;

    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/widget/VideoView;->setVideoURI(Landroid/net/Uri;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    new-instance p2, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$1;

    invoke-direct {p2, p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$1;-><init>(Lchat/ola/vn/activity/OlaReleaseAppActivity$3;)V

    invoke-virtual {p1, p2}, Landroid/widget/VideoView;->setOnErrorListener(Landroid/media/MediaPlayer$OnErrorListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    new-instance p2, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$2;

    invoke-direct {p2, p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$2;-><init>(Lchat/ola/vn/activity/OlaReleaseAppActivity$3;)V

    invoke-virtual {p1, p2}, Landroid/widget/VideoView;->setOnPreparedListener(Landroid/media/MediaPlayer$OnPreparedListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    new-instance p2, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$3;

    invoke-direct {p2, p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity$3$3;-><init>(Lchat/ola/vn/activity/OlaReleaseAppActivity$3;)V

    invoke-virtual {p1, p2}, Landroid/widget/VideoView;->setOnCompletionListener(Landroid/media/MediaPlayer$OnCompletionListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$3;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->n:Landroid/widget/VideoView;

    invoke-virtual {p1}, Landroid/widget/VideoView;->start()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_4
    return-void
.end method
