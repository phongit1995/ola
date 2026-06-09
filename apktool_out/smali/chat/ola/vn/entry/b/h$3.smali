.class Lchat/ola/vn/entry/b/h$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/h;->a(Lchat/ola/vn/entity/e;Landroid/view/ViewGroup;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/e;

.field final synthetic b:Lchat/ola/vn/entity/e;

.field final synthetic c:Landroid/view/View;

.field final synthetic d:Lchat/ola/vn/entry/b/h;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/h;Lchat/ola/vn/entity/e;Lchat/ola/vn/entity/e;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/h$3;->d:Lchat/ola/vn/entry/b/h;

    iput-object p2, p0, Lchat/ola/vn/entry/b/h$3;->a:Lchat/ola/vn/entity/e;

    iput-object p3, p0, Lchat/ola/vn/entry/b/h$3;->b:Lchat/ola/vn/entity/e;

    iput-object p4, p0, Lchat/ola/vn/entry/b/h$3;->c:Landroid/view/View;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/entry/b/h$3;->a:Lchat/ola/vn/entity/e;

    iget-object v0, p0, Lchat/ola/vn/entry/b/h$3;->b:Lchat/ola/vn/entity/e;

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/e;->c(Lchat/ola/vn/entity/e;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/h$3;->d:Lchat/ola/vn/entry/b/h;

    invoke-static {p1}, Lchat/ola/vn/entry/b/h;->e(Lchat/ola/vn/entry/b/h;)Landroid/view/View$OnClickListener;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/entry/b/h$3;->c:Landroid/view/View;

    invoke-interface {p1, v0}, Landroid/view/View$OnClickListener;->onClick(Landroid/view/View;)V

    return-void
.end method
