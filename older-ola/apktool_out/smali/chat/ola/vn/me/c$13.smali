.class Lchat/ola/vn/me/c$13;
.super Lchat/ola/vn/entry/c/c;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/c;->d()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic c:Lchat/ola/vn/me/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/c;Ljava/lang/String;J)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/c$13;->c:Lchat/ola/vn/me/c;

    invoke-direct {p0, p2, p3, p4}, Lchat/ola/vn/entry/c/c;-><init>(Ljava/lang/String;J)V

    return-void
.end method


# virtual methods
.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    invoke-super {p0, p1, p2, p3, p4}, Lchat/ola/vn/entry/c/c;->a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V

    iget-object p1, p0, Lchat/ola/vn/me/c$13;->c:Lchat/ola/vn/me/c;

    invoke-static {p1}, Lchat/ola/vn/me/c;->b(Lchat/ola/vn/me/c;)V

    iget-object p1, p0, Lchat/ola/vn/me/c$13;->c:Lchat/ola/vn/me/c;

    invoke-static {p1}, Lchat/ola/vn/me/c;->c(Lchat/ola/vn/me/c;)Lchat/ola/vn/b/u;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V

    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/entry/c/c;->a([Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/me/c$13;->c:Lchat/ola/vn/me/c;

    invoke-static {p1}, Lchat/ola/vn/me/c;->b(Lchat/ola/vn/me/c;)V

    return-void
.end method
