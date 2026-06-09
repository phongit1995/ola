.class Lchat/ola/vn/q/b$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/q/b;->f(Landroid/content/Context;Lchat/ola/vn/entry/b;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Landroid/content/Context;

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Lchat/ola/vn/entry/b;

.field final synthetic e:Lchat/ola/vn/entity/g;

.field final synthetic f:Lchat/ola/vn/q/b;


# direct methods
.method constructor <init>(Lchat/ola/vn/q/b;Ljava/util/List;Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/entry/b;Lchat/ola/vn/entity/g;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/q/b$2;->f:Lchat/ola/vn/q/b;

    iput-object p2, p0, Lchat/ola/vn/q/b$2;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    iput-object p4, p0, Lchat/ola/vn/q/b$2;->c:Ljava/lang/String;

    iput-object p5, p0, Lchat/ola/vn/q/b$2;->d:Lchat/ola/vn/entry/b;

    iput-object p6, p0, Lchat/ola/vn/q/b$2;->e:Lchat/ola/vn/entity/g;

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
    iget-object p1, p0, Lchat/ola/vn/q/b$2;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    const p3, 0x7f0f042f

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    iget-object p2, p0, Lchat/ola/vn/q/b$2;->c:Ljava/lang/String;

    invoke-static {p1, p2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;)Lchat/ola/vn/i/p;

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    const p3, 0x7f0f04be

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_11

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/network/OlaNetworkService;->p()V

    return-void

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    const p3, 0x7f0f0465

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    const/4 p3, 0x0

    if-eqz p2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p4, p0, Lchat/ola/vn/q/b$2;->c:Ljava/lang/String;

    invoke-static {p1, p2, p4, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;S)V

    return-void

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    const p4, 0x7f0f06a7

    invoke-virtual {p2, p4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_3

    iget-object p1, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    iget-object p2, p0, Lchat/ola/vn/q/b$2;->c:Ljava/lang/String;

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaVipStoreActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    const p4, 0x7f0f0492

    invoke-virtual {p2, p4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_4

    iget-object p1, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "@"

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p3, p0, Lchat/ola/vn/q/b$2;->c:Ljava/lang/String;

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_4
    iget-object p2, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    const p4, 0x7f0f0550

    invoke-virtual {p2, p4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_5

    return-void

    :cond_5
    iget-object p2, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    const p4, 0x7f0f0628

    invoke-virtual {p2, p4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_6

    iget-object p1, p0, Lchat/ola/vn/q/b$2;->f:Lchat/ola/vn/q/b;

    iget-object p2, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    iget-object p3, p0, Lchat/ola/vn/q/b$2;->d:Lchat/ola/vn/entry/b;

    invoke-static {p1, p2, p3}, Lchat/ola/vn/q/b;->b(Lchat/ola/vn/q/b;Landroid/content/Context;Lchat/ola/vn/entry/b;)V

    return-void

    :cond_6
    iget-object p2, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    const p4, 0x7f0f05b3

    invoke-virtual {p2, p4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_7

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_11

    iget-object p2, p0, Lchat/ola/vn/q/b$2;->e:Lchat/ola/vn/entity/g;

    invoke-virtual {p2}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide p2

    invoke-virtual {p1, p2, p3}, Lchat/ola/vn/network/OlaNetworkService;->a(J)V

    return-void

    :cond_7
    iget-object p2, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    const p4, 0x7f0f00fa

    invoke-virtual {p2, p4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_8

    iget-object p1, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    iget-object p2, p0, Lchat/ola/vn/q/b$2;->d:Lchat/ola/vn/entry/b;

    iget-object p2, p2, Lchat/ola/vn/entry/b;->c:Ljava/lang/CharSequence;

    invoke-interface {p2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/m/z;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_8
    iget-object p2, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    const p4, 0x7f0f0491

    invoke-virtual {p2, p4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_c

    iget-object p1, p0, Lchat/ola/vn/q/b$2;->e:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->c()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_9

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, " #\u001b"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p2, p0, Lchat/ola/vn/q/b$2;->e:Lchat/ola/vn/entity/g;

    invoke-virtual {p2}, Lchat/ola/vn/entity/g;->c()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, "#"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_9
    const-string p1, ""
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :goto_0
    :try_start_1
    iget-object p2, p0, Lchat/ola/vn/q/b$2;->d:Lchat/ola/vn/entry/b;

    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->g()Ljava/util/List;

    move-result-object p2

    if-eqz p2, :cond_b

    iget-object p2, p0, Lchat/ola/vn/q/b$2;->d:Lchat/ola/vn/entry/b;

    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->g()Ljava/util/List;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :cond_a
    :goto_1
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result p3

    if-eqz p3, :cond_b

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Ljava/lang/String;

    iget-object p4, p0, Lchat/ola/vn/q/b$2;->e:Lchat/ola/vn/entity/g;

    invoke-virtual {p4}, Lchat/ola/vn/entity/g;->c()Ljava/lang/String;

    move-result-object p4

    invoke-static {p4, p3}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p4

    if-nez p4, :cond_a

    new-instance p4, Ljava/lang/StringBuilder;

    invoke-direct {p4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p5, " #\u001b"

    invoke-virtual {p4, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p4, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p3, "#"

    invoke-virtual {p4, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object p1, p3

    goto :goto_1

    :catch_0
    :cond_b
    :try_start_2
    iget-object p2, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object p4, p0, Lchat/ola/vn/q/b$2;->e:Lchat/ola/vn/entity/g;

    invoke-virtual {p4}, Lchat/ola/vn/entity/g;->b()Ljava/lang/String;

    move-result-object p4

    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :goto_2
    invoke-static {p2, p1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_c
    iget-object p2, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    const p4, 0x7f0f0493

    invoke-virtual {p2, p4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_f

    iget-object p1, p0, Lchat/ola/vn/q/b$2;->e:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->c()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_d

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, " #\u001b"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p2, p0, Lchat/ola/vn/q/b$2;->e:Lchat/ola/vn/entity/g;

    invoke-virtual {p2}, Lchat/ola/vn/entity/g;->c()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, "#"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_3

    :cond_d
    const-string p1, ""

    :goto_3
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object p3, p0, Lchat/ola/vn/q/b$2;->e:Lchat/ola/vn/entity/g;

    invoke-virtual {p3}, Lchat/ola/vn/entity/g;->b()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_11

    iget-object p2, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    invoke-static {p2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-eqz p3, :cond_e

    goto :goto_4

    :cond_e
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, " "

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :goto_4
    iget-object p2, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    goto :goto_2

    :cond_f
    iget-object p2, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    const p4, 0x7f0f04ae

    invoke-virtual {p2, p4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_10

    iget-object v0, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    iget-object p1, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    invoke-virtual {p1, p4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object p1, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    const p2, 0x7f0f0221

    const/4 p5, 0x1

    new-array p5, p5, [Ljava/lang/Object;

    iget-object v2, p0, Lchat/ola/vn/q/b$2;->c:Ljava/lang/String;

    aput-object v2, p5, p3

    invoke-virtual {p1, p2, p5}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    iget-object p1, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    invoke-virtual {p1, p4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    iget-object p1, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    const p2, 0x7f0f044d

    invoke-virtual {p1, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/q/b$2$1;

    invoke-direct {v5, p0}, Lchat/ola/vn/q/b$2$1;-><init>(Lchat/ola/vn/q/b$2;)V

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;

    return-void

    :cond_10
    iget-object p2, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    const p3, 0x7f0f056b

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_11

    iget-object p1, p0, Lchat/ola/vn/q/b$2;->f:Lchat/ola/vn/q/b;

    iget-object p2, p0, Lchat/ola/vn/q/b$2;->b:Landroid/content/Context;

    iget-object p3, p0, Lchat/ola/vn/q/b$2;->d:Lchat/ola/vn/entry/b;

    invoke-static {p1, p2, p3}, Lchat/ola/vn/q/b;->c(Lchat/ola/vn/q/b;Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_11
    return-void
.end method
