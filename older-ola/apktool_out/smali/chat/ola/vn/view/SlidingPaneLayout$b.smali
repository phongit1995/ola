.class Lchat/ola/vn/view/SlidingPaneLayout$b;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/view/SlidingPaneLayout;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field final a:Landroid/view/View;

.field final synthetic b:Lchat/ola/vn/view/SlidingPaneLayout;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/SlidingPaneLayout;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/SlidingPaneLayout$b;->b:Lchat/ola/vn/view/SlidingPaneLayout;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lchat/ola/vn/view/SlidingPaneLayout$b;->a:Landroid/view/View;

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout$b;->a:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/view/SlidingPaneLayout$b;->b:Lchat/ola/vn/view/SlidingPaneLayout;

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout$b;->a:Landroid/view/View;

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/support/v4/view/ViewCompat;->setLayerType(Landroid/view/View;ILandroid/graphics/Paint;)V

    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout$b;->b:Lchat/ola/vn/view/SlidingPaneLayout;

    iget-object v1, p0, Lchat/ola/vn/view/SlidingPaneLayout$b;->a:Landroid/view/View;

    invoke-static {v0, v1}, Lchat/ola/vn/view/SlidingPaneLayout;->a(Lchat/ola/vn/view/SlidingPaneLayout;Landroid/view/View;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/SlidingPaneLayout$b;->b:Lchat/ola/vn/view/SlidingPaneLayout;

    invoke-static {v0}, Lchat/ola/vn/view/SlidingPaneLayout;->f(Lchat/ola/vn/view/SlidingPaneLayout;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    return-void
.end method
