.class public Lchat/ola/vn/util/i;
.super Ljava/lang/Object;


# static fields
.field public static a:Ljava/lang/String; = "((rss|Rss|RSS)://((?:[a-z0-9]+[a-zA-Z0-9\\-_/\\.]+))(\\b|\\s))"

.field public static b:Ljava/lang/String; = "\\b(file)://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]"

.field public static c:Ljava/lang/String; = "(?:(?:ht|f)tp(?:s?)://)(?:(?:[-\\w]+\\.)+(?:[-\\w]+))(?::[\\d]{1,5})?(?:(?:(?:/(?:[-\\w~!$+|.,=]|%[a-f\\d]{2})+)+|/)+|\\?|#)?(?:(\\S)*)"

.field public static d:Ljava/lang/String; = "(\\B#((?:[a-zA-Z0-9][a-zA-Z0-9_.]*[a-zA-Z0-9])))"

.field public static e:Ljava/lang/String; = "(\\B@((?:[a-zA-Z][a-zA-Z0-9_]*[.]?[a-zA-Z0-9_]*[a-zA-Z0-9])))"

.field private static f:Lchat/ola/vn/entry/f;

.field private static g:Lchat/ola/vn/entry/f;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method private static a()Lchat/ola/vn/entry/f;
    .locals 1

    sget-object v0, Lchat/ola/vn/util/i;->f:Lchat/ola/vn/entry/f;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/util/i$8;

    invoke-direct {v0}, Lchat/ola/vn/util/i$8;-><init>()V

    sput-object v0, Lchat/ola/vn/util/i;->f:Lchat/ola/vn/entry/f;

    :cond_0
    sget-object v0, Lchat/ola/vn/util/i;->f:Lchat/ola/vn/entry/f;

    return-object v0
.end method

.method public static a(Landroid/view/View;Lcom/mg/ola/common/widget/OlaTextView$b;Ljava/lang/String;)Ljava/lang/CharSequence;
    .locals 1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/util/i;->a()Lchat/ola/vn/entry/f;

    move-result-object v0

    invoke-interface {v0, p0, p1, p2}, Lchat/ola/vn/entry/f;->a(Landroid/view/View;Lcom/mg/ola/common/widget/OlaTextView$b;Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-object p2
.end method

.method public static a(Landroid/view/View;Ljava/lang/CharSequence;Lcom/mg/ola/common/widget/OlaTextView$b;IZ)Ljava/lang/CharSequence;
    .locals 8

    instance-of v0, p1, Landroid/text/SpannableString;

    if-eqz v0, :cond_0

    move-object v0, p1

    check-cast v0, Landroid/text/SpannableString;

    goto :goto_0

    :cond_0
    new-instance v0, Landroid/text/SpannableString;

    invoke-direct {v0, p1}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    :goto_0
    sget-object v1, Lchat/ola/vn/util/i;->a:Ljava/lang/String;

    const/4 v2, 0x2

    invoke-static {v1, v2}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;I)Ljava/util/regex/Pattern;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p1

    :goto_1
    invoke-virtual {p1}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {p1}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v7

    if-nez p2, :cond_1

    new-instance v1, Lcom/mg/ola/common/d/a/a;

    invoke-direct {v1, p3, p4}, Lcom/mg/ola/common/d/a/a;-><init>(IZ)V

    goto :goto_2

    :cond_1
    new-instance v1, Lchat/ola/vn/util/i$1;

    move-object v2, v1

    move v3, p3

    move v4, p4

    move-object v5, p2

    move-object v6, p0

    invoke-direct/range {v2 .. v7}, Lchat/ola/vn/util/i$1;-><init>(IZLcom/mg/ola/common/widget/OlaTextView$b;Landroid/view/View;Ljava/lang/String;)V

    :goto_2
    invoke-virtual {p1}, Ljava/util/regex/Matcher;->start()I

    move-result v2

    invoke-virtual {p1}, Ljava/util/regex/Matcher;->end()I

    move-result v3

    const/16 v4, 0x21

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V

    goto :goto_1

    :cond_2
    return-object v0
.end method

.method public static a(Landroid/view/View;Ljava/lang/String;)Ljava/lang/CharSequence;
    .locals 1

    invoke-static {}, Lchat/ola/vn/q/a;->a()Lchat/ola/vn/q/a;

    move-result-object v0

    invoke-static {p0, v0, p1}, Lchat/ola/vn/util/i;->a(Landroid/view/View;Lcom/mg/ola/common/widget/OlaTextView$b;Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static a(Ljava/lang/CharSequence;II)Ljava/lang/CharSequence;
    .locals 9

    :try_start_0
    instance-of v0, p0, Landroid/text/SpannableString;

    if-eqz v0, :cond_0

    move-object v0, p0

    check-cast v0, Landroid/text/SpannableString;

    goto :goto_0

    :cond_0
    new-instance v0, Landroid/text/SpannableString;

    invoke-direct {v0, p0}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    :goto_0
    const-string v1, "\\B#[#|\u001b]((?:[0-9][PSVAO][a-z0-9][a-zA-Z0-9]{3}[u0-9]?[a-zA-Z0-9]{7,}))#"

    invoke-static {v1}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v1

    :goto_1
    invoke-virtual {v1}, Ljava/util/regex/Matcher;->find()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-virtual {v1}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x2

    invoke-virtual {v1}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    const/4 v5, 0x1

    sub-int/2addr v4, v5

    invoke-virtual {v2, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/entity/i;->b(Ljava/lang/String;)[I

    move-result-object v3

    const/4 v4, 0x0

    aget v6, v3, v4

    if-lez v6, :cond_1

    aget v6, v3, v5

    if-lez v6, :cond_1

    aget v6, v3, v4

    invoke-static {v6, p1}, Ljava/lang/Math;->min(II)I

    move-result p1

    aget v3, v3, v5

    invoke-static {v3, p2}, Ljava/lang/Math;->min(II)I

    move-result p2

    :cond_1
    sget v3, Lchat/ola/vn/e;->c:I

    if-lt p1, v3, :cond_2

    int-to-float p1, p1

    int-to-float p2, p2

    div-float/2addr p1, p2

    sget p2, Lchat/ola/vn/e;->c:I

    int-to-float v3, p2

    div-float/2addr v3, p1

    float-to-int p1, v3

    move v8, p2

    move p2, p1

    move p1, v8

    :cond_2
    new-instance v3, Lchat/ola/vn/view/a;

    invoke-direct {v3, p1, p2}, Lchat/ola/vn/view/a;-><init>(II)V

    invoke-virtual {v3, v2}, Lchat/ola/vn/view/a;->a(Ljava/lang/String;)V

    new-instance v5, Landroid/text/style/ImageSpan;

    invoke-direct {v5, v3, v4}, Landroid/text/style/ImageSpan;-><init>(Landroid/graphics/drawable/Drawable;I)V

    new-instance v3, Lchat/ola/vn/util/i$5;

    invoke-direct {v3, v4, v4, v2}, Lchat/ola/vn/util/i$5;-><init>(IZLjava/lang/String;)V

    invoke-virtual {v1}, Ljava/util/regex/Matcher;->start()I

    move-result v2

    invoke-virtual {v1}, Ljava/util/regex/Matcher;->end()I

    move-result v4

    new-instance v6, Landroid/text/style/AlignmentSpan$Standard;

    sget-object v7, Landroid/text/Layout$Alignment;->ALIGN_NORMAL:Landroid/text/Layout$Alignment;

    invoke-direct {v6, v7}, Landroid/text/style/AlignmentSpan$Standard;-><init>(Landroid/text/Layout$Alignment;)V

    const/16 v7, 0x21

    invoke-virtual {v0, v6, v2, v4, v7}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V

    invoke-virtual {v0, v5, v2, v4, v7}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V

    add-int/lit8 v4, v4, -0x1

    invoke-virtual {v0, v3, v2, v4, v7}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :cond_3
    return-object v0

    :catch_0
    return-object p0
.end method

.method public static a(Ljava/lang/String;Lcom/mg/ola/common/widget/OlaTextView$b;)Ljava/lang/CharSequence;
    .locals 1

    const/4 v0, 0x0

    invoke-static {v0, p1, p0}, Lchat/ola/vn/util/i;->a(Landroid/view/View;Lcom/mg/ola/common/widget/OlaTextView$b;Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static a(Ljava/lang/CharSequence;)Ljava/lang/String;
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, v0}, Lchat/ola/vn/util/i;->c(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static a(Ljava/lang/String;)Ljava/util/ArrayList;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const-string v1, "<([^>]+)>"

    invoke-static {v1}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p0

    :goto_0
    invoke-virtual {p0}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    invoke-virtual {p0, v1}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :cond_0
    return-object v0

    :catch_0
    const/4 p0, 0x0

    return-object p0
.end method

.method public static a(Ljava/lang/String;CC)Ljava/util/ArrayList;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "CC)",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, -0x1

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, -0x1

    :goto_0
    if-ge v4, v1, :cond_3

    if-nez v5, :cond_0

    invoke-virtual {p0, v4}, Ljava/lang/String;->charAt(I)C

    move-result v7

    if-ne v7, p1, :cond_2

    add-int/lit8 v5, v4, 0x1

    const/4 v6, 0x1

    move v6, v5

    const/4 v5, 0x1

    goto :goto_1

    :cond_0
    invoke-virtual {p0, v4}, Ljava/lang/String;->charAt(I)C

    move-result v7

    if-ne v7, p2, :cond_2

    if-lez v6, :cond_2

    if-le v4, v6, :cond_1

    invoke-virtual {p0, v6, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    const/4 v5, 0x0

    const/4 v6, -0x1

    :cond_2
    :goto_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_3
    return-object v0

    :catch_0
    const/4 p0, 0x0

    return-object p0
.end method

.method public static a(Ljava/lang/CharSequence;Ljava/lang/String;Ljava/lang/StringBuffer;)Ljava/util/List;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/CharSequence;",
            "Ljava/lang/String;",
            "Ljava/lang/StringBuffer;",
            ")",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    :cond_0
    :try_start_0
    const-string v1, "\\B#[#|\u001b]((?:[0-9][PSVAO][a-z0-9][a-zA-Z0-9]{3}[u0-9]?[a-zA-Z0-9]{7,}))#"

    invoke-static {v1}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p0

    move-object v1, v0

    :cond_1
    :goto_0
    invoke-virtual {p0}, Ljava/util/regex/Matcher;->find()Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-virtual {p0}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x2

    invoke-virtual {p0}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    add-int/lit8 v4, v4, -0x1

    invoke-virtual {v2, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    if-nez v1, :cond_2

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    :goto_1
    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_2

    :cond_2
    invoke-interface {v1, v2}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    goto :goto_1

    :cond_3
    :goto_2
    if-eqz p1, :cond_1

    invoke-virtual {p0, p2, p1}, Ljava/util/regex/Matcher;->appendReplacement(Ljava/lang/StringBuffer;Ljava/lang/String;)Ljava/util/regex/Matcher;

    goto :goto_0

    :cond_4
    invoke-virtual {p0, p2}, Ljava/util/regex/Matcher;->appendTail(Ljava/lang/StringBuffer;)Ljava/lang/StringBuffer;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    :catch_0
    return-object v0
.end method

.method public static a(Ljava/lang/CharSequence;Z)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/CharSequence;",
            "Z)",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    :cond_0
    :try_start_0
    sget-object v1, Lchat/ola/vn/util/i;->c:Ljava/lang/String;

    const/4 v2, 0x2

    invoke-static {v1, v2}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;I)Ljava/util/regex/Pattern;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p0

    :catch_0
    :cond_1
    :goto_0
    invoke-virtual {p0}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-virtual {p0}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-nez v2, :cond_1

    :try_start_1
    invoke-static {v1}, Lchat/ola/vn/util/m;->e(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    if-nez v0, :cond_2

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    move-object v0, v2

    :cond_2
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :cond_3
    if-eqz p1, :cond_4

    :try_start_2
    const-string p1, ""

    invoke-virtual {p0, p1}, Ljava/util/regex/Matcher;->replaceAll(Ljava/lang/String;)Ljava/lang/String;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_4
    return-object v0
.end method

.method public static a(Ljava/lang/CharSequence;Ljava/lang/String;)Z
    .locals 2

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "(\\B@"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, ")"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x2

    invoke-static {p1, v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;I)Ljava/util/regex/Pattern;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p0

    invoke-virtual {p0}, Ljava/util/regex/Matcher;->find()Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    return p0

    :catch_0
    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method public static b(Landroid/view/View;Ljava/lang/CharSequence;Lcom/mg/ola/common/widget/OlaTextView$b;IZ)Ljava/lang/CharSequence;
    .locals 8

    instance-of v0, p1, Landroid/text/SpannableString;

    if-eqz v0, :cond_0

    move-object v0, p1

    check-cast v0, Landroid/text/SpannableString;

    goto :goto_0

    :cond_0
    new-instance v0, Landroid/text/SpannableString;

    invoke-direct {v0, p1}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    :goto_0
    sget-object v1, Lchat/ola/vn/util/i;->c:Ljava/lang/String;

    const/4 v2, 0x2

    invoke-static {v1, v2}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;I)Ljava/util/regex/Pattern;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p1

    :catch_0
    :goto_1
    invoke-virtual {p1}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_2

    :try_start_0
    invoke-virtual {p1}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v7

    if-nez p2, :cond_1

    new-instance v1, Lcom/mg/ola/common/d/a/a;

    invoke-direct {v1, p3, p4}, Lcom/mg/ola/common/d/a/a;-><init>(IZ)V

    goto :goto_2

    :cond_1
    new-instance v1, Lchat/ola/vn/util/i$2;

    move-object v2, v1

    move v3, p3

    move v4, p4

    move-object v5, p2

    move-object v6, p0

    invoke-direct/range {v2 .. v7}, Lchat/ola/vn/util/i$2;-><init>(IZLcom/mg/ola/common/widget/OlaTextView$b;Landroid/view/View;Ljava/lang/String;)V

    :goto_2
    invoke-virtual {p1}, Ljava/util/regex/Matcher;->start()I

    move-result v2

    invoke-virtual {p1}, Ljava/util/regex/Matcher;->end()I

    move-result v3

    const/16 v4, 0x21

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :cond_2
    return-object v0
.end method

.method public static b(Ljava/lang/CharSequence;II)Ljava/lang/CharSequence;
    .locals 9

    :try_start_0
    instance-of v0, p0, Landroid/text/SpannableString;

    if-eqz v0, :cond_0

    move-object v0, p0

    check-cast v0, Landroid/text/SpannableString;

    goto :goto_0

    :cond_0
    new-instance v0, Landroid/text/SpannableString;

    invoke-direct {v0, p0}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    :goto_0
    sget-object v1, Lchat/ola/vn/util/i;->b:Ljava/lang/String;

    invoke-static {v1}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v1

    :goto_1
    invoke-virtual {v1}, Ljava/util/regex/Matcher;->find()Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-virtual {v1}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v3, 0x0

    :try_start_1
    const-string v4, "file:\\"

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v5

    invoke-virtual {v2, v4, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    const-string v5, "UTF-8"

    invoke-static {v4, v5}, Ljava/net/URLDecoder;->decode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object v3, v4

    :catch_0
    :try_start_2
    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1

    return-object p0

    :cond_1
    invoke-static {v3}, Lcom/mg/ola/common/d/f;->a(Ljava/lang/String;)[I

    move-result-object v4

    const/4 v5, 0x0

    aget v6, v4, v5

    if-lez v6, :cond_2

    const/4 v6, 0x1

    aget v7, v4, v6

    if-lez v7, :cond_2

    aget v7, v4, v5

    invoke-static {v7, p1}, Ljava/lang/Math;->min(II)I

    move-result p1

    aget v4, v4, v6

    invoke-static {v4, p2}, Ljava/lang/Math;->min(II)I

    move-result p2

    :cond_2
    sget v4, Lchat/ola/vn/e;->c:I

    if-lt p1, v4, :cond_3

    int-to-float p1, p1

    int-to-float p2, p2

    div-float/2addr p1, p2

    sget p2, Lchat/ola/vn/e;->c:I

    int-to-float v4, p2

    div-float/2addr v4, p1

    float-to-int p1, v4

    move v8, p2

    move p2, p1

    move p1, v8

    :cond_3
    new-instance v4, Lchat/ola/vn/view/a;

    invoke-direct {v4, p1, p2}, Lchat/ola/vn/view/a;-><init>(II)V

    invoke-virtual {v4, v2}, Lchat/ola/vn/view/a;->b(Ljava/lang/String;)V

    new-instance v2, Landroid/text/style/ImageSpan;

    invoke-direct {v2, v4, v5}, Landroid/text/style/ImageSpan;-><init>(Landroid/graphics/drawable/Drawable;I)V

    new-instance v4, Lchat/ola/vn/util/i$6;

    invoke-direct {v4, v5, v5, v3}, Lchat/ola/vn/util/i$6;-><init>(IZLjava/lang/String;)V

    invoke-virtual {v1}, Ljava/util/regex/Matcher;->start()I

    move-result v3

    invoke-virtual {v1}, Ljava/util/regex/Matcher;->end()I

    move-result v5

    new-instance v6, Landroid/text/style/AlignmentSpan$Standard;

    sget-object v7, Landroid/text/Layout$Alignment;->ALIGN_NORMAL:Landroid/text/Layout$Alignment;

    invoke-direct {v6, v7}, Landroid/text/style/AlignmentSpan$Standard;-><init>(Landroid/text/Layout$Alignment;)V

    const/16 v7, 0x21

    invoke-virtual {v0, v6, v3, v5, v7}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V

    invoke-virtual {v0, v2, v3, v5, v7}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V

    add-int/lit8 v5, v5, -0x1

    invoke-virtual {v0, v4, v3, v5, v7}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_1

    :cond_4
    return-object v0

    :catch_1
    return-object p0
.end method

.method public static b(Ljava/lang/String;)Ljava/lang/CharSequence;
    .locals 3

    :try_start_0
    sget-object v0, Lchat/ola/vn/util/i;->g:Lchat/ola/vn/entry/f;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/util/i$7;

    invoke-direct {v0}, Lchat/ola/vn/util/i$7;-><init>()V

    sput-object v0, Lchat/ola/vn/util/i;->g:Lchat/ola/vn/entry/f;

    :cond_0
    sget-object v0, Lchat/ola/vn/util/i;->g:Lchat/ola/vn/entry/f;

    const/4 v1, 0x0

    invoke-static {}, Lchat/ola/vn/q/a;->a()Lchat/ola/vn/q/a;

    move-result-object v2

    invoke-interface {v0, v1, v2, p0}, Lchat/ola/vn/entry/f;->a(Landroid/view/View;Lcom/mg/ola/common/widget/OlaTextView$b;Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-object p0
.end method

.method public static b(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lchat/ola/vn/util/i;->e:Ljava/lang/String;

    const/4 v2, 0x2

    invoke-static {v1, v2}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;I)Ljava/util/regex/Pattern;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p0

    :goto_0
    invoke-virtual {p0}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_1

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static b(Ljava/lang/CharSequence;)Ljava/util/ArrayList;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/CharSequence;",
            ")",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const-string v1, "\\B#[#|\u001b]((?:[0-9][PSVAO][a-z0-9][a-zA-Z0-9]{3}[u0-9]?[a-zA-Z0-9]{7,}))#"

    invoke-static {v1}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p0

    :cond_0
    :goto_0
    invoke-virtual {p0}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {p0}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x2

    invoke-virtual {p0}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    add-int/lit8 v3, v3, -0x1

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    return-object v0
.end method

.method public static b(Ljava/lang/CharSequence;Z)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/CharSequence;",
            "Z)",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    :cond_0
    :try_start_0
    sget-object v1, Lchat/ola/vn/util/i;->c:Ljava/lang/String;

    const/4 v2, 0x2

    invoke-static {v1, v2}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;I)Ljava/util/regex/Pattern;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p0

    :catch_0
    :cond_1
    :goto_0
    invoke-virtual {p0}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-virtual {p0}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-nez v2, :cond_1

    :try_start_1
    invoke-static {v1}, Lchat/ola/vn/util/m;->g(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    if-nez v0, :cond_2

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    move-object v0, v2

    :cond_2
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :cond_3
    if-eqz p1, :cond_4

    :try_start_2
    const-string p1, ""

    invoke-virtual {p0, p1}, Ljava/util/regex/Matcher;->replaceAll(Ljava/lang/String;)Ljava/lang/String;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_4
    return-object v0
.end method

.method public static c(Landroid/view/View;Ljava/lang/CharSequence;Lcom/mg/ola/common/widget/OlaTextView$b;IZ)Ljava/lang/CharSequence;
    .locals 8

    instance-of v0, p1, Landroid/text/SpannableString;

    if-eqz v0, :cond_0

    move-object v0, p1

    check-cast v0, Landroid/text/SpannableString;

    goto :goto_0

    :cond_0
    new-instance v0, Landroid/text/SpannableString;

    invoke-direct {v0, p1}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    :goto_0
    sget-object v1, Lchat/ola/vn/util/i;->e:Ljava/lang/String;

    const/4 v2, 0x2

    invoke-static {v1, v2}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;I)Ljava/util/regex/Pattern;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p1

    :catch_0
    :goto_1
    invoke-virtual {p1}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_2

    :try_start_0
    invoke-virtual {p1}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v7

    if-nez p2, :cond_1

    new-instance v1, Lcom/mg/ola/common/d/a/a;

    invoke-direct {v1, p3, p4}, Lcom/mg/ola/common/d/a/a;-><init>(IZ)V

    goto :goto_2

    :cond_1
    new-instance v1, Lchat/ola/vn/util/i$3;

    move-object v2, v1

    move v3, p3

    move v4, p4

    move-object v5, p2

    move-object v6, p0

    invoke-direct/range {v2 .. v7}, Lchat/ola/vn/util/i$3;-><init>(IZLcom/mg/ola/common/widget/OlaTextView$b;Landroid/view/View;Ljava/lang/String;)V

    :goto_2
    invoke-virtual {p1}, Ljava/util/regex/Matcher;->start()I

    move-result v2

    invoke-virtual {p1}, Ljava/util/regex/Matcher;->end()I

    move-result v3

    const/16 v4, 0x21

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :cond_2
    return-object v0
.end method

.method public static c(Ljava/lang/String;)Ljava/lang/CharSequence;
    .locals 2

    invoke-static {}, Lchat/ola/vn/q/a;->a()Lchat/ola/vn/q/a;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {v1, v0, p0}, Lchat/ola/vn/util/i;->a(Landroid/view/View;Lcom/mg/ola/common/widget/OlaTextView$b;Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object p0

    return-object p0
.end method

.method public static c(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lchat/ola/vn/util/i;->d:Ljava/lang/String;

    const/4 v2, 0x2

    invoke-static {v1, v2}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;I)Ljava/util/regex/Pattern;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p0

    :goto_0
    invoke-virtual {p0}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_1

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static c(Ljava/lang/CharSequence;)Ljava/util/ArrayList;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/CharSequence;",
            ")",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sget-object v1, Lchat/ola/vn/util/i;->b:Ljava/lang/String;

    const/4 v2, 0x2

    invoke-static {v1, v2}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;I)Ljava/util/regex/Pattern;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p0

    :cond_0
    :goto_0
    invoke-virtual {p0}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {p0}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :cond_1
    return-object v0

    :catch_0
    const/4 p0, 0x0

    return-object p0
.end method

.method public static d(Landroid/view/View;Ljava/lang/CharSequence;Lcom/mg/ola/common/widget/OlaTextView$b;IZ)Ljava/lang/CharSequence;
    .locals 8

    instance-of v0, p1, Landroid/text/SpannableString;

    if-eqz v0, :cond_0

    move-object v0, p1

    check-cast v0, Landroid/text/SpannableString;

    goto :goto_0

    :cond_0
    new-instance v0, Landroid/text/SpannableString;

    invoke-direct {v0, p1}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    :goto_0
    sget-object v1, Lchat/ola/vn/util/i;->d:Ljava/lang/String;

    const/4 v2, 0x2

    invoke-static {v1, v2}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;I)Ljava/util/regex/Pattern;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p1

    :catch_0
    :goto_1
    invoke-virtual {p1}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_2

    :try_start_0
    invoke-virtual {p1}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v7

    if-nez p2, :cond_1

    new-instance v1, Lcom/mg/ola/common/d/a/a;

    invoke-direct {v1, p3, p4}, Lcom/mg/ola/common/d/a/a;-><init>(IZ)V

    goto :goto_2

    :cond_1
    new-instance v1, Lchat/ola/vn/util/i$4;

    move-object v2, v1

    move v3, p3

    move v4, p4

    move-object v5, p2

    move-object v6, p0

    invoke-direct/range {v2 .. v7}, Lchat/ola/vn/util/i$4;-><init>(IZLcom/mg/ola/common/widget/OlaTextView$b;Landroid/view/View;Ljava/lang/String;)V

    :goto_2
    invoke-virtual {p1}, Ljava/util/regex/Matcher;->start()I

    move-result v2

    invoke-virtual {p1}, Ljava/util/regex/Matcher;->end()I

    move-result v3

    const/16 v4, 0x21

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :cond_2
    return-object v0
.end method

.method public static d(Ljava/lang/CharSequence;)Ljava/lang/String;
    .locals 3

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    :cond_0
    :try_start_0
    sget-object v1, Lchat/ola/vn/util/i;->c:Ljava/lang/String;

    const/4 v2, 0x2

    invoke-static {v1, v2}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;I)Ljava/util/regex/Pattern;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p0

    :catch_0
    :cond_1
    invoke-virtual {p0}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {p0}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-nez v2, :cond_1

    :try_start_1
    invoke-static {v1}, Lchat/ola/vn/util/m;->e(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    if-nez v2, :cond_1

    return-object v1

    :catch_1
    :cond_2
    return-object v0
.end method

.method public static d(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    if-eqz p0, :cond_1

    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const-string v0, "\\B#[#|\u001b]((?:[0-9][PSVAO][a-z0-9][a-zA-Z0-9]{3}[u0-9]?[a-zA-Z0-9]{7,}))#"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/util/regex/Matcher;->replaceAll(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_1
    :goto_0
    const-string p0, ""

    return-object p0
.end method

.method public static e(Ljava/lang/CharSequence;)Ljava/lang/String;
    .locals 3

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    :cond_0
    :try_start_0
    sget-object v1, Lchat/ola/vn/util/i;->a:Ljava/lang/String;

    const/4 v2, 0x2

    invoke-static {v1, v2}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;I)Ljava/util/regex/Pattern;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p0

    invoke-virtual {p0}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {p0}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    :cond_1
    return-object v0
.end method

.method public static f(Ljava/lang/CharSequence;)Ljava/lang/String;
    .locals 3

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    :cond_0
    :try_start_0
    sget-object v1, Lchat/ola/vn/util/i;->c:Ljava/lang/String;

    const/4 v2, 0x2

    invoke-static {v1, v2}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;I)Ljava/util/regex/Pattern;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p0

    invoke-virtual {p0}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {p0}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    :cond_1
    return-object v0
.end method

.method public static g(Ljava/lang/CharSequence;)Ljava/lang/String;
    .locals 3

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    :cond_0
    :try_start_0
    sget-object v1, Lchat/ola/vn/util/i;->c:Ljava/lang/String;

    const/4 v2, 0x2

    invoke-static {v1, v2}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;I)Ljava/util/regex/Pattern;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p0

    :catch_0
    :cond_1
    invoke-virtual {p0}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-virtual {p0}, Ljava/util/regex/Matcher;->group()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-nez v2, :cond_1

    :try_start_1
    invoke-static {v1}, Lchat/ola/vn/util/m;->g(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    if-nez v2, :cond_1

    return-object v1

    :catch_1
    :cond_2
    return-object v0
.end method
