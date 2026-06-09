.class Lchat/ola/vn/b/ae$a$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/b/ae$a;->a(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/b/ae$a;


# direct methods
.method constructor <init>(Lchat/ola/vn/b/ae$a;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/ae$a$1;->b:Lchat/ola/vn/b/ae$a;

    iput-object p2, p0, Lchat/ola/vn/b/ae$a$1;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/ae$a$1;->a:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/b/ae$a$1;->b:Lchat/ola/vn/b/ae$a;

    iget-object v0, v0, Lchat/ola/vn/b/ae$a;->c:Lchat/ola/vn/b/ae;

    invoke-static {v0}, Lchat/ola/vn/b/ae;->a(Lchat/ola/vn/b/ae;)Landroid/view/View$OnClickListener;

    move-result-object v0

    invoke-interface {v0, p1}, Landroid/view/View$OnClickListener;->onClick(Landroid/view/View;)V

    return-void
.end method
