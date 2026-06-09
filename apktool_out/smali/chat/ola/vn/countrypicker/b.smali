.class public Lchat/ola/vn/countrypicker/b;
.super Landroid/widget/BaseAdapter;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/countrypicker/b$a;
    }
.end annotation


# instance fields
.field a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/countrypicker/a;",
            ">;"
        }
    .end annotation
.end field

.field b:Landroid/view/LayoutInflater;

.field private c:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lchat/ola/vn/countrypicker/a;",
            ">;)V"
        }
    .end annotation

    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/countrypicker/b;->c:Landroid/content/Context;

    iput-object p2, p0, Lchat/ola/vn/countrypicker/b;->a:Ljava/util/List;

    iget-object p1, p0, Lchat/ola/vn/countrypicker/b;->c:Landroid/content/Context;

    const-string p2, "layout_inflater"

    invoke-virtual {p1, p2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/view/LayoutInflater;

    iput-object p1, p0, Lchat/ola/vn/countrypicker/b;->b:Landroid/view/LayoutInflater;

    return-void
.end method

.method private a(Ljava/lang/String;)I
    .locals 2

    :try_start_0
    const-class v0, Lchat/ola/vn/i$a;

    invoke-virtual {v0, p1}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    move-exception p1

    const-string v0, "COUNTRYPICKER"

    const-string v1, "Failure to get drawable id."

    invoke-static {v0, v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const/4 p1, -0x1

    return p1
.end method


# virtual methods
.method public getCount()I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/countrypicker/b;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getItem(I)Ljava/lang/Object;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public getItemId(I)J
    .locals 2

    const-wide/16 v0, 0x0

    return-wide v0
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 5

    iget-object p3, p0, Lchat/ola/vn/countrypicker/b;->a:Ljava/util/List;

    invoke-interface {p3, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/countrypicker/a;

    if-nez p2, :cond_0

    new-instance p2, Lchat/ola/vn/countrypicker/b$a;

    invoke-direct {p2}, Lchat/ola/vn/countrypicker/b$a;-><init>()V

    iget-object p3, p0, Lchat/ola/vn/countrypicker/b;->b:Landroid/view/LayoutInflater;

    const v0, 0x7f0b019c

    const/4 v1, 0x0

    invoke-virtual {p3, v0, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p3

    const v0, 0x7f090437

    invoke-virtual {p3, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p2, Lchat/ola/vn/countrypicker/b$a;->a:Landroid/widget/TextView;

    const v0, 0x7f090435

    invoke-virtual {p3, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p2, Lchat/ola/vn/countrypicker/b$a;->b:Landroid/widget/TextView;

    const v0, 0x7f090436

    invoke-virtual {p3, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p2, Lchat/ola/vn/countrypicker/b$a;->c:Landroid/widget/ImageView;

    invoke-virtual {p3, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lchat/ola/vn/countrypicker/b$a;

    move-object v4, p3

    move-object p3, p2

    move-object p2, v4

    :goto_0
    iget-object v0, p2, Lchat/ola/vn/countrypicker/b$a;->a:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/countrypicker/a;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p1}, Lchat/ola/vn/countrypicker/a;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    iget-object v1, p2, Lchat/ola/vn/countrypicker/b$a;->b:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "+"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_1
    iget-object v0, p2, Lchat/ola/vn/countrypicker/b$a;->b:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "flag_"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/countrypicker/a;->a()Ljava/lang/String;

    move-result-object p1

    sget-object v1, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {p1, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object p2, p2, Lchat/ola/vn/countrypicker/b$a;->c:Landroid/widget/ImageView;

    invoke-direct {p0, p1}, Lchat/ola/vn/countrypicker/b;->a(Ljava/lang/String;)I

    move-result p1

    invoke-virtual {p2, p1}, Landroid/widget/ImageView;->setImageResource(I)V

    return-object p3
.end method
