.class Lchat/ola/vn/q/b$3$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/q/b$3;->onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/q/b$3;


# direct methods
.method constructor <init>(Lchat/ola/vn/q/b$3;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/q/b$3$1;->a:Lchat/ola/vn/q/b$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    if-nez p2, :cond_3

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p2, :cond_2

    iget-object v0, p0, Lchat/ola/vn/q/b$3$1;->a:Lchat/ola/vn/q/b$3;

    iget-object v0, v0, Lchat/ola/vn/q/b$3;->d:Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/q/b$3$1;->a:Lchat/ola/vn/q/b$3;

    iget-object v0, v0, Lchat/ola/vn/q/b$3;->e:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v0

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->b(J)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/q/b$3$1;->a:Lchat/ola/vn/q/b$3;

    iget-object v0, v0, Lchat/ola/vn/q/b$3;->d:Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/q/b$3$1;->a:Lchat/ola/vn/q/b$3;

    iget-object v0, v0, Lchat/ola/vn/q/b$3;->e:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->m()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lchat/ola/vn/network/OlaNetworkService;->r(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/q/b$3$1;->a:Lchat/ola/vn/q/b$3;

    iget-object v0, v0, Lchat/ola/vn/q/b$3;->d:Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_2

    iget-object v0, p0, Lchat/ola/vn/q/b$3$1;->a:Lchat/ola/vn/q/b$3;

    iget-object v0, v0, Lchat/ola/vn/q/b$3;->e:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->m()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lchat/ola/vn/network/OlaNetworkService;->s(Ljava/lang/String;)V

    :cond_2
    :goto_0
    sget-object p2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    iget-object v0, p0, Lchat/ola/vn/q/b$3$1;->a:Lchat/ola/vn/q/b$3;

    iget-object v0, v0, Lchat/ola/vn/q/b$3;->d:Lchat/ola/vn/entry/b;

    invoke-virtual {p2, v0}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/entry/b;)Z

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/c;->j()V

    :cond_3
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
