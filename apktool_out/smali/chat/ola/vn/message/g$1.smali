.class Lchat/ola/vn/message/g$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/message/g;->e(Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/message/f;

.field final synthetic b:I

.field final synthetic c:Lchat/ola/vn/message/g;


# direct methods
.method constructor <init>(Lchat/ola/vn/message/g;Lchat/ola/vn/message/f;I)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/g$1;->c:Lchat/ola/vn/message/g;

    iput-object p2, p0, Lchat/ola/vn/message/g$1;->a:Lchat/ola/vn/message/f;

    iput p3, p0, Lchat/ola/vn/message/g$1;->b:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/message/g$1;->a:Lchat/ola/vn/message/f;

    iget-object v0, v0, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/message/g$1;->a:Lchat/ola/vn/message/f;

    iget-object v1, p0, Lchat/ola/vn/message/g$1;->a:Lchat/ola/vn/message/f;

    iget-object v1, v1, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    invoke-static {v0, v1}, Lchat/ola/vn/util/c/b;->a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V

    return-void

    :cond_0
    iget v0, p0, Lchat/ola/vn/message/g$1;->b:I

    invoke-static {v0}, Lchat/ola/vn/util/c/b;->a(I)V

    return-void
.end method
