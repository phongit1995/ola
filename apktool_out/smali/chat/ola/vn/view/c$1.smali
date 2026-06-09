.class Lchat/ola/vn/view/c$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/c;->a(Lcom/mg/ola/common/a/a;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/a/a;

.field final synthetic b:Z

.field final synthetic c:Lchat/ola/vn/view/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/c;Lcom/mg/ola/common/a/a;Z)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/c$1;->c:Lchat/ola/vn/view/c;

    iput-object p2, p0, Lchat/ola/vn/view/c$1;->a:Lcom/mg/ola/common/a/a;

    iput-boolean p3, p0, Lchat/ola/vn/view/c$1;->b:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/view/c$1;->c:Lchat/ola/vn/view/c;

    iget-object v1, p0, Lchat/ola/vn/view/c$1;->a:Lcom/mg/ola/common/a/a;

    iget-boolean v2, p0, Lchat/ola/vn/view/c$1;->b:Z

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/view/c;->a(Lcom/mg/ola/common/a/a;Z)V

    return-void
.end method
