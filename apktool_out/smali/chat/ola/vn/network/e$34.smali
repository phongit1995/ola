.class Lchat/ola/vn/network/e$34;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->b(Ljava/lang/String;Lchat/ola/vn/message/d;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/message/d;

.field final synthetic c:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/lang/String;Lchat/ola/vn/message/d;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$34;->c:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$34;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/network/e$34;->b:Lchat/ola/vn/message/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/network/e$34;->c:Lchat/ola/vn/network/e;

    iget-object v1, p0, Lchat/ola/vn/network/e$34;->a:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/network/e$34;->b:Lchat/ola/vn/message/d;

    const/4 v3, 0x2

    invoke-static {v0, v1, v3, v2}, Lchat/ola/vn/network/e;->a(Lchat/ola/vn/network/e;Ljava/lang/String;SLchat/ola/vn/message/d;)V

    return-void
.end method
