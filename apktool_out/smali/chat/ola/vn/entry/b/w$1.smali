.class Lchat/ola/vn/entry/b/w$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/w;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/w;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/w;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/w$1;->a:Lchat/ola/vn/entry/b/w;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/b/w$1;->a:Lchat/ola/vn/entry/b/w;

    iget-object v0, v0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {p1, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w$1;->a:Lchat/ola/vn/entry/b/w;

    iget-object v0, v0, Lchat/ola/vn/entry/b/w;->a:Landroid/view/View$OnClickListener;

    invoke-interface {v0, p1}, Landroid/view/View$OnClickListener;->onClick(Landroid/view/View;)V

    return-void
.end method
