.class Lchat/ola/vn/signup/fb/a$c$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/fb/a$c;->a(Lchat/ola/vn/signup/fb/a$b;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/fb/a$c;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/fb/a$c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/fb/a$c$1;->a:Lchat/ola/vn/signup/fb/a$c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/signup/fb/a$c$1;->a:Lchat/ola/vn/signup/fb/a$c;

    invoke-static {v0}, Lchat/ola/vn/signup/fb/a$c;->a(Lchat/ola/vn/signup/fb/a$c;)Lchat/ola/vn/signup/fb/a$b;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/signup/fb/a$c$1;->a:Lchat/ola/vn/signup/fb/a$c;

    invoke-static {v0}, Lchat/ola/vn/signup/fb/a$c;->b(Lchat/ola/vn/signup/fb/a$c;)Landroid/view/View$OnClickListener;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/signup/fb/a$c$1;->a:Lchat/ola/vn/signup/fb/a$c;

    invoke-static {v0}, Lchat/ola/vn/signup/fb/a$c;->b(Lchat/ola/vn/signup/fb/a$c;)Landroid/view/View$OnClickListener;

    move-result-object v0

    invoke-interface {v0, p1}, Landroid/view/View$OnClickListener;->onClick(Landroid/view/View;)V

    :cond_0
    return-void
.end method
