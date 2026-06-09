.class Lchat/ola/vn/b/ad$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/b/ad;->a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/ah;

.field final synthetic b:Lchat/ola/vn/b/ad;


# direct methods
.method constructor <init>(Lchat/ola/vn/b/ad;Lchat/ola/vn/entity/ah;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/ad$1;->b:Lchat/ola/vn/b/ad;

    iput-object p2, p0, Lchat/ola/vn/b/ad$1;->a:Lchat/ola/vn/entity/ah;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/ad$1;->a:Lchat/ola/vn/entity/ah;

    invoke-virtual {p1, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/b/ad$1;->b:Lchat/ola/vn/b/ad;

    invoke-static {v0}, Lchat/ola/vn/b/ad;->a(Lchat/ola/vn/b/ad;)Landroid/view/View$OnClickListener;

    move-result-object v0

    invoke-interface {v0, p1}, Landroid/view/View$OnClickListener;->onClick(Landroid/view/View;)V

    return-void
.end method
