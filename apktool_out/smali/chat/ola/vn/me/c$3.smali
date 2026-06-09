.class Lchat/ola/vn/me/c$3;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/c;->a(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/c$3;->a:Lchat/ola/vn/me/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/me/c$3;->a:Lchat/ola/vn/me/c;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/me/c;->d(Lchat/ola/vn/me/c;Z)V

    return-void
.end method
