.class Lchat/ola/vn/view/i$d$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/animation/Animation$AnimationListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/i$d;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/w;

.field final synthetic b:Lchat/ola/vn/view/i$d;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/i$d;Lchat/ola/vn/entity/w;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/i$d$1;->b:Lchat/ola/vn/view/i$d;

    iput-object p2, p0, Lchat/ola/vn/view/i$d$1;->a:Lchat/ola/vn/entity/w;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationEnd(Landroid/view/animation/Animation;)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/view/i$d$1;->a:Lchat/ola/vn/entity/w;

    const/4 v0, 0x0

    iput-boolean v0, p1, Lchat/ola/vn/entity/w;->c:Z

    return-void
.end method

.method public onAnimationRepeat(Landroid/view/animation/Animation;)V
    .locals 0

    return-void
.end method

.method public onAnimationStart(Landroid/view/animation/Animation;)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/view/i$d$1;->a:Lchat/ola/vn/entity/w;

    const/4 v0, 0x1

    iput-boolean v0, p1, Lchat/ola/vn/entity/w;->c:Z

    return-void
.end method
