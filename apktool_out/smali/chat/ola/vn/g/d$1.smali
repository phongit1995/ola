.class Lchat/ola/vn/g/d$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/g/d;->a(Landroid/content/Context;Landroid/view/View;IJ)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Landroid/content/Context;

.field final synthetic c:Lchat/ola/vn/g/d;


# direct methods
.method constructor <init>(Lchat/ola/vn/g/d;Ljava/util/List;Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/g/d$1;->c:Lchat/ola/vn/g/d;

    iput-object p2, p0, Lchat/ola/vn/g/d$1;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/g/d$1;->b:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 6
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
    iget-object p1, p0, Lchat/ola/vn/g/d$1;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/g/d$1;->b:Landroid/content/Context;

    const p3, 0x7f0f069f

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/g/d$1;->b:Landroid/content/Context;

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p3, p0, Lchat/ola/vn/g/d$1;->c:Lchat/ola/vn/g/d;

    iget-object p3, p3, Lchat/ola/vn/g/d;->d:Lchat/ola/vn/message/f;

    invoke-virtual {p3}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p3

    invoke-static {p1, p2, p3}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/g/d$1;->b:Landroid/content/Context;

    const p3, 0x7f0f0453

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/g/d$1;->c:Lchat/ola/vn/g/d;

    iget-object p2, p0, Lchat/ola/vn/g/d$1;->b:Landroid/content/Context;

    invoke-static {p1, p2}, Lchat/ola/vn/g/d;->a(Lchat/ola/vn/g/d;Landroid/content/Context;)V

    return-void

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/g/d$1;->b:Landroid/content/Context;

    const p3, 0x7f0f04a6

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    const/4 p4, 0x0

    const/4 p5, 0x1

    if-eqz p2, :cond_2

    iget-object v0, p0, Lchat/ola/vn/g/d$1;->b:Landroid/content/Context;

    iget-object p1, p0, Lchat/ola/vn/g/d$1;->b:Landroid/content/Context;

    const p2, 0x7f0f009b

    invoke-virtual {p1, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object p1, p0, Lchat/ola/vn/g/d$1;->b:Landroid/content/Context;

    const p2, 0x7f0f04b2

    new-array p5, p5, [Ljava/lang/Object;

    iget-object v2, p0, Lchat/ola/vn/g/d$1;->c:Lchat/ola/vn/g/d;

    iget-object v2, v2, Lchat/ola/vn/g/d;->d:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v2

    aput-object v2, p5, p4

    invoke-virtual {p1, p2, p5}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    iget-object p1, p0, Lchat/ola/vn/g/d$1;->b:Landroid/content/Context;

    invoke-virtual {p1, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    iget-object p1, p0, Lchat/ola/vn/g/d$1;->b:Landroid/content/Context;

    const p2, 0x7f0f0577

    invoke-virtual {p1, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/g/d$1$1;

    invoke-direct {v5, p0}, Lchat/ola/vn/g/d$1$1;-><init>(Lchat/ola/vn/g/d$1;)V

    :goto_0
    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;

    return-void

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/g/d$1;->b:Landroid/content/Context;

    const p3, 0x7f0f043a

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object v0, p0, Lchat/ola/vn/g/d$1;->b:Landroid/content/Context;

    iget-object p1, p0, Lchat/ola/vn/g/d$1;->b:Landroid/content/Context;

    const p2, 0x7f0f0184

    invoke-virtual {p1, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object p1, p0, Lchat/ola/vn/g/d$1;->b:Landroid/content/Context;

    const p2, 0x7f0f0183

    new-array p3, p5, [Ljava/lang/Object;

    new-instance p5, Ljava/lang/StringBuilder;

    invoke-direct {p5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "@"

    invoke-virtual {p5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/g/d$1;->c:Lchat/ola/vn/g/d;

    iget-object v2, v2, Lchat/ola/vn/g/d;->d:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p5

    aput-object p5, p3, p4

    invoke-virtual {p1, p2, p3}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    iget-object p1, p0, Lchat/ola/vn/g/d$1;->b:Landroid/content/Context;

    const p2, 0x7f0f0439

    invoke-virtual {p1, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    iget-object p1, p0, Lchat/ola/vn/g/d$1;->b:Landroid/content/Context;

    const p2, 0x7f0f044d

    invoke-virtual {p1, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/g/d$1$2;

    invoke-direct {v5, p0}, Lchat/ola/vn/g/d$1$2;-><init>(Lchat/ola/vn/g/d$1;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_3
    return-void
.end method
