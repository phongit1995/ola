.class Lchat/ola/vn/m/j$14;
.super Lchat/ola/vn/entry/c/d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/j;->a(Lchat/ola/vn/entity/t;Ljava/lang/Runnable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/Runnable;

.field final synthetic b:Lchat/ola/vn/m/j;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/j;Lchat/ola/vn/entity/t;Ljava/lang/String;Ljava/lang/Runnable;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/j$14;->b:Lchat/ola/vn/m/j;

    iput-object p4, p0, Lchat/ola/vn/m/j$14;->a:Ljava/lang/Runnable;

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/entry/c/d;-><init>(Lchat/ola/vn/entity/t;Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    invoke-super {p0, p1, p2, p3, p4}, Lchat/ola/vn/entry/c/d;->a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V

    iget-object p1, p0, Lchat/ola/vn/m/j$14;->a:Ljava/lang/Runnable;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/j$14;->a:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    :cond_0
    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/entry/c/d;->a([Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/m/j$14;->a:Ljava/lang/Runnable;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/j$14;->a:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    :cond_0
    return-void
.end method
