.class Lchat/ola/vn/entry/b/ab$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnLongClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/ab;->h()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/ab;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/ab;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/ab$2;->a:Lchat/ola/vn/entry/b/ab;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onLongClick(Landroid/view/View;)Z
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab$2;->a:Lchat/ola/vn/entry/b/ab;

    iget-object v0, v0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {p1, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab$2;->a:Lchat/ola/vn/entry/b/ab;

    iget-object v0, v0, Lchat/ola/vn/entry/b/ab;->e:Landroid/view/View$OnLongClickListener;

    invoke-interface {v0, p1}, Landroid/view/View$OnLongClickListener;->onLongClick(Landroid/view/View;)Z

    move-result p1

    return p1
.end method
