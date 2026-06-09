.class public Lchat/ola/vn/util/g;
.super Ljava/lang/Object;


# static fields
.field private static c:Lchat/ola/vn/util/g;


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/util/regex/Pattern;

.field private d:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/16 v1, 0x2000

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->appendCodePoint(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "-"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/16 v1, 0x2b55

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->appendCodePoint(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const v1, 0x1f000

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->appendCodePoint(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "-"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v1, 0x1f6ff

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->appendCodePoint(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/util/g;->a:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/util/g;->a:Ljava/lang/String;

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/util/g;->b:Ljava/util/regex/Pattern;

    invoke-direct {p0}, Lchat/ola/vn/util/g;->b()V

    return-void
.end method

.method private a(Ljava/util/Map;[Lchat/ola/vn/entry/h;)I
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Integer;",
            ">;[",
            "Lchat/ola/vn/entry/h;",
            ")I"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    array-length v1, p2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    :try_start_1
    aget-object v4, p2, v2

    invoke-virtual {v4}, Lchat/ola/vn/entry/h;->a()[I

    move-result-object v5

    array-length v6, v5
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    move v7, v3

    const/4 v3, 0x0

    :goto_1
    if-ge v3, v6, :cond_0

    :try_start_2
    aget v8, v5, v3

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    iget v9, v4, Lchat/ola/vn/entry/h;->d:I

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    invoke-interface {p1, v8, v9}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    add-int/lit8 v7, v7, 0x1

    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :catch_0
    move-exception p1

    move v3, v7

    goto :goto_2

    :cond_0
    add-int/lit8 v2, v2, 0x1

    move v3, v7

    goto :goto_0

    :catch_1
    move-exception p1

    goto :goto_2

    :catch_2
    move-exception p1

    const/4 v3, 0x0

    :goto_2
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return v3
.end method

.method public static a()Lchat/ola/vn/util/g;
    .locals 1

    sget-object v0, Lchat/ola/vn/util/g;->c:Lchat/ola/vn/util/g;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/util/g;

    invoke-direct {v0}, Lchat/ola/vn/util/g;-><init>()V

    sput-object v0, Lchat/ola/vn/util/g;->c:Lchat/ola/vn/util/g;

    :cond_0
    sget-object v0, Lchat/ola/vn/util/g;->c:Lchat/ola/vn/util/g;

    return-object v0
.end method

.method private b()V
    .locals 2

    new-instance v0, Ljava/util/TreeMap;

    invoke-direct {v0}, Ljava/util/TreeMap;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/util/g;->d:Ljava/util/Map;

    iget-object v0, p0, Lchat/ola/vn/util/g;->d:Ljava/util/Map;

    sget-object v1, Lchat/ola/vn/r/c;->c:[Lchat/ola/vn/entry/h;

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/util/g;->a(Ljava/util/Map;[Lchat/ola/vn/entry/h;)I

    iget-object v0, p0, Lchat/ola/vn/util/g;->d:Ljava/util/Map;

    sget-object v1, Lchat/ola/vn/r/c;->d:[Lchat/ola/vn/entry/h;

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/util/g;->a(Ljava/util/Map;[Lchat/ola/vn/entry/h;)I

    iget-object v0, p0, Lchat/ola/vn/util/g;->d:Ljava/util/Map;

    sget-object v1, Lchat/ola/vn/r/c;->b:[Lchat/ola/vn/entry/h;

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/util/g;->a(Ljava/util/Map;[Lchat/ola/vn/entry/h;)I

    iget-object v0, p0, Lchat/ola/vn/util/g;->d:Ljava/util/Map;

    sget-object v1, Lchat/ola/vn/r/c;->e:[Lchat/ola/vn/entry/h;

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/util/g;->a(Ljava/util/Map;[Lchat/ola/vn/entry/h;)I

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;
    .locals 5

    if-nez p1, :cond_0

    const-string p1, ""

    return-object p1

    :cond_0
    instance-of v0, p1, Landroid/text/SpannableString;

    if-eqz v0, :cond_1

    move-object v0, p1

    check-cast v0, Landroid/text/SpannableString;

    goto :goto_0

    :cond_1
    new-instance v0, Landroid/text/SpannableString;

    invoke-direct {v0, p1}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    :goto_0
    iget-object v1, p0, Lchat/ola/vn/util/g;->b:Ljava/util/regex/Pattern;

    invoke-virtual {v1, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p1

    :cond_2
    :goto_1
    invoke-virtual {p1}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_3

    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->codePointAt(I)I

    move-result v2

    iget-object v3, p0, Lchat/ola/vn/util/g;->d:Ljava/util/Map;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v3, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    if-eqz v2, :cond_2

    new-instance v3, Landroid/text/style/ImageSpan;

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v4

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    invoke-direct {v3, v4, v2, v1}, Landroid/text/style/ImageSpan;-><init>(Landroid/content/Context;II)V

    invoke-virtual {p1}, Ljava/util/regex/Matcher;->start()I

    move-result v1

    invoke-virtual {p1}, Ljava/util/regex/Matcher;->end()I

    move-result v2

    const/16 v4, 0x21

    invoke-virtual {v0, v3, v1, v2, v4}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V

    goto :goto_1

    :cond_3
    return-object v0
.end method

.method public a(I)Ljava/lang/Integer;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/g;->d:Ljava/util/Map;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Integer;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method
