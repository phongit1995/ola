.class Lchat/ola/vn/b/t$a$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/b/t$a;->a(Lchat/ola/vn/h/a;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/b/t$a;


# direct methods
.method constructor <init>(Lchat/ola/vn/b/t$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/t$a$1;->a:Lchat/ola/vn/b/t$a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/t$a$1;->a:Lchat/ola/vn/b/t$a;

    iget-object v0, v0, Lchat/ola/vn/b/t$a;->d:Lchat/ola/vn/h/a;

    invoke-virtual {p1, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/b/t$a$1;->a:Lchat/ola/vn/b/t$a;

    iget-object v0, v0, Lchat/ola/vn/b/t$a;->e:Lchat/ola/vn/b/t;

    invoke-static {v0}, Lchat/ola/vn/b/t;->a(Lchat/ola/vn/b/t;)Landroid/view/View$OnClickListener;

    move-result-object v0

    invoke-interface {v0, p1}, Landroid/view/View$OnClickListener;->onClick(Landroid/view/View;)V

    return-void
.end method
