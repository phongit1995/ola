.class Lchat/ola/vn/tutorial/a$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/tutorial/a;->a(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/tutorial/a;


# direct methods
.method constructor <init>(Lchat/ola/vn/tutorial/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/tutorial/a$2;->a:Lchat/ola/vn/tutorial/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/tutorial/a$2;->a:Lchat/ola/vn/tutorial/a;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/tutorial/a;->a(Lchat/ola/vn/tutorial/a;Z)V

    return-void
.end method
