.class Lchat/ola/vn/m/l$7;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/l;->a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/l;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/l;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/l$7;->a:Lchat/ola/vn/m/l;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/l$7;->a:Lchat/ola/vn/m/l;

    invoke-static {v0}, Lchat/ola/vn/m/l;->g(Lchat/ola/vn/m/l;)Landroid/view/animation/Animation;

    move-result-object v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/l$7;->a:Lchat/ola/vn/m/l;

    iget-object v1, p0, Lchat/ola/vn/m/l$7;->a:Lchat/ola/vn/m/l;

    invoke-virtual {v1}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    const v2, 0x7f010051

    invoke-static {v1, v2}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/m/l;->a(Lchat/ola/vn/m/l;Landroid/view/animation/Animation;)Landroid/view/animation/Animation;

    iget-object v0, p0, Lchat/ola/vn/m/l$7;->a:Lchat/ola/vn/m/l;

    invoke-static {v0}, Lchat/ola/vn/m/l;->g(Lchat/ola/vn/m/l;)Landroid/view/animation/Animation;

    move-result-object v0

    const-wide/16 v1, 0x96

    invoke-virtual {v0, v1, v2}, Landroid/view/animation/Animation;->setDuration(J)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/l$7;->a:Lchat/ola/vn/m/l;

    invoke-static {v0}, Lchat/ola/vn/m/l;->g(Lchat/ola/vn/m/l;)Landroid/view/animation/Animation;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/animation/Animation;->cancel()V

    iget-object v0, p0, Lchat/ola/vn/m/l$7;->a:Lchat/ola/vn/m/l;

    invoke-static {v0}, Lchat/ola/vn/m/l;->h(Lchat/ola/vn/m/l;)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/m/l$7;->a:Lchat/ola/vn/m/l;

    invoke-static {v1}, Lchat/ola/vn/m/l;->g(Lchat/ola/vn/m/l;)Landroid/view/animation/Animation;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/m/l$7;->a:Lchat/ola/vn/m/l;

    invoke-static {v0}, Lchat/ola/vn/m/l;->h(Lchat/ola/vn/m/l;)Landroid/widget/TextView;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    return-void
.end method
