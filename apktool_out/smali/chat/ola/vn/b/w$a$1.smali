.class Lchat/ola/vn/b/w$a$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/b/w$a;->a(Lchat/ola/vn/message/f;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/message/f;

.field final synthetic b:Lchat/ola/vn/b/w$a;


# direct methods
.method constructor <init>(Lchat/ola/vn/b/w$a;Lchat/ola/vn/message/f;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/w$a$1;->b:Lchat/ola/vn/b/w$a;

    iput-object p2, p0, Lchat/ola/vn/b/w$a$1;->a:Lchat/ola/vn/message/f;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/w$a$1;->a:Lchat/ola/vn/message/f;

    invoke-virtual {p1, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/b/w$a$1;->b:Lchat/ola/vn/b/w$a;

    iget-object v0, v0, Lchat/ola/vn/b/w$a;->d:Lchat/ola/vn/b/w;

    invoke-static {v0}, Lchat/ola/vn/b/w;->a(Lchat/ola/vn/b/w;)Landroid/view/View$OnClickListener;

    move-result-object v0

    invoke-interface {v0, p1}, Landroid/view/View$OnClickListener;->onClick(Landroid/view/View;)V

    return-void
.end method
