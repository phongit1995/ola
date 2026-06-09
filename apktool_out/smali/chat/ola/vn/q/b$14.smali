.class Lchat/ola/vn/q/b$14;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/q/b;->d(Landroid/content/Context;Lchat/ola/vn/entry/b;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Landroid/content/Context;

.field final synthetic c:Lchat/ola/vn/entity/g;

.field final synthetic d:Ljava/lang/String;

.field final synthetic e:Ljava/lang/String;

.field final synthetic f:Lchat/ola/vn/q/b;


# direct methods
.method constructor <init>(Lchat/ola/vn/q/b;Ljava/util/List;Landroid/content/Context;Lchat/ola/vn/entity/g;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/q/b$14;->f:Lchat/ola/vn/q/b;

    iput-object p2, p0, Lchat/ola/vn/q/b$14;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/q/b$14;->b:Landroid/content/Context;

    iput-object p4, p0, Lchat/ola/vn/q/b$14;->c:Lchat/ola/vn/entity/g;

    iput-object p5, p0, Lchat/ola/vn/q/b$14;->d:Ljava/lang/String;

    iput-object p6, p0, Lchat/ola/vn/q/b$14;->e:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/q/b$14;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/q/b$14;->b:Landroid/content/Context;

    const p3, 0x7f0f0441

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_6

    iget-object p2, p0, Lchat/ola/vn/q/b$14;->c:Lchat/ola/vn/entity/g;

    invoke-virtual {p2}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide p2

    iget-object p4, p0, Lchat/ola/vn/q/b$14;->d:Ljava/lang/String;

    invoke-virtual {p1, p2, p3, p4}, Lchat/ola/vn/network/OlaNetworkService;->b(JLjava/lang/String;)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/q/b$14;->b:Landroid/content/Context;

    const p3, 0x7f0f05b4

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_6

    iget-object p2, p0, Lchat/ola/vn/q/b$14;->c:Lchat/ola/vn/entity/g;

    invoke-virtual {p2}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide p2

    iget-object p4, p0, Lchat/ola/vn/q/b$14;->d:Ljava/lang/String;

    invoke-virtual {p1, p2, p3, p4}, Lchat/ola/vn/network/OlaNetworkService;->a(JLjava/lang/String;)V

    return-void

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/q/b$14;->b:Landroid/content/Context;

    const p3, 0x7f0f04bf

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_6

    iget-object p2, p0, Lchat/ola/vn/q/b$14;->d:Ljava/lang/String;

    invoke-virtual {p1, p2}, Lchat/ola/vn/network/OlaNetworkService;->q(Ljava/lang/String;)V

    return-void

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/q/b$14;->b:Landroid/content/Context;

    const p3, 0x7f0f0218

    const/4 p4, 0x1

    new-array p5, p4, [Ljava/lang/Object;

    iget-object v0, p0, Lchat/ola/vn/q/b$14;->e:Ljava/lang/String;

    const/4 v1, 0x0

    aput-object v0, p5, v1

    invoke-virtual {p2, p3, p5}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_3

    iget-object v2, p0, Lchat/ola/vn/q/b$14;->b:Landroid/content/Context;

    iget-object p1, p0, Lchat/ola/vn/q/b$14;->b:Landroid/content/Context;

    const p2, 0x7f0f04ae

    invoke-virtual {p1, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    iget-object p1, p0, Lchat/ola/vn/q/b$14;->b:Landroid/content/Context;

    const p2, 0x7f0f0217

    const/4 p3, 0x2

    new-array p3, p3, [Ljava/lang/Object;

    iget-object p5, p0, Lchat/ola/vn/q/b$14;->e:Ljava/lang/String;

    aput-object p5, p3, v1

    iget-object p5, p0, Lchat/ola/vn/q/b$14;->d:Ljava/lang/String;

    aput-object p5, p3, p4

    invoke-virtual {p1, p2, p3}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    iget-object p1, p0, Lchat/ola/vn/q/b$14;->b:Landroid/content/Context;

    const p2, 0x7f0f04a9

    invoke-virtual {p1, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v5

    iget-object p1, p0, Lchat/ola/vn/q/b$14;->b:Landroid/content/Context;

    const p2, 0x7f0f044d

    invoke-virtual {p1, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v6

    new-instance v7, Lchat/ola/vn/q/b$14$1;

    invoke-direct {v7, p0}, Lchat/ola/vn/q/b$14$1;-><init>(Lchat/ola/vn/q/b$14;)V

    invoke-static/range {v2 .. v7}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;

    return-void

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/q/b$14;->b:Landroid/content/Context;

    const p3, 0x7f0f0493

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/q/b$14;->c:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->c()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_4

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, " #\u001b"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p2, p0, Lchat/ola/vn/q/b$14;->c:Lchat/ola/vn/entity/g;

    invoke-virtual {p2}, Lchat/ola/vn/entity/g;->c()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, "#"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_4
    const-string p1, ""

    :goto_0
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object p3, p0, Lchat/ola/vn/q/b$14;->c:Lchat/ola/vn/entity/g;

    invoke-virtual {p3}, Lchat/ola/vn/entity/g;->b()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_6

    iget-object p2, p0, Lchat/ola/vn/q/b$14;->b:Landroid/content/Context;

    invoke-static {p2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-eqz p3, :cond_5

    goto :goto_1

    :cond_5
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, " "

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :goto_1
    iget-object p2, p0, Lchat/ola/vn/q/b$14;->b:Landroid/content/Context;

    invoke-static {p2, p1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_6
    return-void
.end method
