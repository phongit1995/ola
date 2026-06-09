.class Lchat/ola/vn/m/l$5;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/l;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/l;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/l;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/l$5;->a:Lchat/ola/vn/m/l;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/m/l$5;->a:Lchat/ola/vn/m/l;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lchat/ola/vn/m/l;->a(Lchat/ola/vn/m/l;Z)V

    iget-object v0, p0, Lchat/ola/vn/m/l$5;->a:Lchat/ola/vn/m/l;

    invoke-static {v0}, Lchat/ola/vn/m/l;->f(Lchat/ola/vn/m/l;)V

    return-void
.end method
