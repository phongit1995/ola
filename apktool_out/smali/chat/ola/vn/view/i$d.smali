.class Lchat/ola/vn/view/i$d;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/view/i;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "d"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/view/i;

.field private b:Lchat/ola/vn/view/OlaCachedImageView;

.field private c:Landroid/view/View;


# direct methods
.method public constructor <init>(Lchat/ola/vn/view/i;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/i$d;->a:Lchat/ola/vn/view/i;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f09049d

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/i$d;->c:Landroid/view/View;

    const p1, 0x7f09049c

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/view/i$d;->b:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object p1, p0, Lchat/ola/vn/view/i$d;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/w;)V
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/view/i$d;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    invoke-virtual {p1}, Lchat/ola/vn/entity/w;->a()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v3, p0, Lchat/ola/vn/view/i$d;->b:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v4, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    iget-object v5, p0, Lchat/ola/vn/view/i$d;->c:Landroid/view/View;

    const/16 v6, 0xf0

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;I)V

    iget-object p1, p0, Lchat/ola/vn/view/i$d;->b:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    :cond_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 4

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f09049c

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/w;

    iget-boolean v1, v0, Lchat/ola/vn/entity/w;->c:Z

    if-nez v1, :cond_3

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v1

    sget-object v2, Lchat/ola/vn/util/c/a;->y:Landroid/net/Uri;

    invoke-static {v1, v2}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/view/i$d;->a:Lchat/ola/vn/view/i;

    invoke-virtual {v1}, Lchat/ola/vn/view/i;->getContext()Landroid/content/Context;

    move-result-object v1

    const v2, 0x7f010021

    invoke-static {v1, v2}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v1

    const-wide/16 v2, 0x7d0

    invoke-virtual {v1, v2, v3}, Landroid/view/animation/Animation;->setDuration(J)V

    new-instance v2, Lchat/ola/vn/view/i$d$1;

    invoke-direct {v2, p0, v0}, Lchat/ola/vn/view/i$d$1;-><init>(Lchat/ola/vn/view/i$d;Lchat/ola/vn/entity/w;)V

    invoke-virtual {v1, v2}, Landroid/view/animation/Animation;->setAnimationListener(Landroid/view/animation/Animation$AnimationListener;)V

    invoke-virtual {p1, v1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object p1, p0, Lchat/ola/vn/view/i$d;->a:Lchat/ola/vn/view/i;

    iget-object p1, p1, Lchat/ola/vn/view/i;->a:Lchat/ola/vn/view/i$e;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/view/i$d;->a:Lchat/ola/vn/view/i;

    iget-object p1, p1, Lchat/ola/vn/view/i;->a:Lchat/ola/vn/view/i$e;

    invoke-interface {p1, v0}, Lchat/ola/vn/view/i$e;->a(Lchat/ola/vn/entity/w;)V

    :cond_2
    invoke-static {v0}, Lchat/ola/vn/view/i;->a(Lchat/ola/vn/entity/w;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    return-void
.end method
