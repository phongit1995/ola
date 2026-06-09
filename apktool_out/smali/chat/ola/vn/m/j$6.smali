.class Lchat/ola/vn/m/j$6;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/j;->b(Lchat/ola/vn/entity/t;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/t;

.field final synthetic b:Lchat/ola/vn/m/j;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/j;Lchat/ola/vn/entity/t;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/j$6;->b:Lchat/ola/vn/m/j;

    iput-object p2, p0, Lchat/ola/vn/m/j$6;->a:Lchat/ola/vn/entity/t;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 4

    if-nez p2, :cond_1

    sget-object p2, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {p2}, Lchat/ola/vn/r/b;->b()Z

    move-result p2

    if-eqz p2, :cond_1

    move-object p2, p1

    check-cast p2, Lchat/ola/vn/i/p;

    invoke-virtual {p2}, Lchat/ola/vn/i/p;->a()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    sget-object v0, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    iget-object v1, p0, Lchat/ola/vn/m/j$6;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {v1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/r/b;->a(Ljava/lang/String;)Lchat/ola/vn/entity/t;

    move-result-object v1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    if-eqz v1, :cond_0

    invoke-virtual {v1, p2}, Lchat/ola/vn/entity/t;->b(Ljava/lang/String;)V

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/entity/t;->e(J)V

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/entity/t;->d(J)V

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/m/j$6;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {v1, p2}, Lchat/ola/vn/entity/t;->b(Ljava/lang/String;)V

    iget-object p2, p0, Lchat/ola/vn/m/j$6;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {p2, v2, v3}, Lchat/ola/vn/entity/t;->e(J)V

    iget-object p2, p0, Lchat/ola/vn/m/j$6;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {v0, p2}, Lchat/ola/vn/r/b;->a(Lchat/ola/vn/entity/t;)V

    invoke-virtual {v0}, Lchat/ola/vn/r/b;->h()V

    :goto_0
    sget-object p2, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {p2}, Lchat/ola/vn/r/b;->h()V

    iget-object p2, p0, Lchat/ola/vn/m/j$6;->b:Lchat/ola/vn/m/j;

    invoke-virtual {p2}, Lchat/ola/vn/m/j;->e()V

    :cond_1
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
